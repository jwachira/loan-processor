module AffirmLoanProcessor
  class LoanProcessor
    DATA_SOURCE = './data/loans.csv'.freeze
    attr_reader :loans_file_path

    def initialize(loans_file_path = DATA_SOURCE)
      @loans_file_path = loans_file_path
    end

    def process!
      covenants = Model::Covenant.all
      facilities = Model::Facility.all

      CSV.foreach(loans_file_path, headers: true).each_with_object([[], []]) do |row, (assignments, yields)|
        loan = Model::Loan.new(id: row['id'].to_i,
          amount: row['amount'].to_i,
          interest_rate: row['interest_rate'].to_f,
          default_likelihood: row['default_likelihood'].to_f,
          state: row['state']
        )
        
        facility_service = Model::Facility.find_funding_facility(loan)

        assignments.push({
                          facility_id: facility_service[:facility]&.id,
                          loan_id: loan.id
                        })
        yields.push({
                      facility_id: facility_service[:facility]&.id,
                      expected_yield: facility_service[:expected_yield]
                    })
      end
    end
  end
end
