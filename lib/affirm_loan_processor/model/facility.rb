module AffirmLoanProcessor
  module Model
    class Facility
      DATA_SOURCE = './data/facilities.csv'
      attr_accessor :id, :bank_id, :interest_rate, :amount,
                    :available_balance, :assignments

      def initialize(id:, bank_id:, interest_rate:, amount:)
        @id = id
        @bank_id = bank_id
        @amount = amount
        @interest_rate = interest_rate
      end

      def self.all
        CSV.foreach(DATA_SOURCE, headers: true).each_with_object([]) do |row, facilities|
          facility =  Facility.new(id: row['id'].to_i,
                                   bank_id: row['bank_id'].to_i,
                                   amount: row['amount'].to_i,
                                   interest_rate: row['interest_rate'].to_f)
          facilities.push(facility)
        end
      end

      def self.find(facility_id)
        all[facility_id.to_s]
      end

      def self.find_funding_facility(loan)
         all.each_with_object({}) do |facility, best_deal|
          next unless (loan.amount <= facility.amount) && (loan.interest_rate >= facility.interest_rate)

          next unless Covenant.requirements_met?(facility.id, loan)

          new_expected_yield = Loan.expected_yield(facility, loan)

          if best_deal[:facility].nil? || new_expected_yield > best_deal[:expected_yield]
            best_deal[:expected_yield] = new_expected_yield
            best_deal[:facility] = facility
          end
        end
      end
    end
  end
end
