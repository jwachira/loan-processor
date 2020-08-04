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
         all.each_with_object({}) do |facility, facility_match|
          next unless (loan.amount <= facility.amount) && (loan.interest_rate >= facility.interest_rate)

          next unless Covenant.requirements_met?(facility.id, loan)

          new_interest = loan.amount * facility.interest_rate

          if facility_match[:facility].nil? || new_interest.to_f < facility_match[:interest].to_f
            facility_match[:interest] = new_interest
            facility_match[:facility] = facility
          end
        end[:facility]
      end
    end
  end
end
