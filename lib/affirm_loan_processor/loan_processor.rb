module AffirmLoanProcessor
  class LoanProcessor
    DATA_SOURCE = './data/loans.csv'.freeze
    attr_reader :loan_file_path

    def initialize(loan_file_path = DATA_SOURCE)
      @loan_file_path = loan_file_path
    end

    def process!
      covenants = AffirmLoanProcessor::Model::Covenant.all
      facilities = AffirmLoanProcessor::Model::Facility.all

      CSV.foreach(loan_file_path, headers: true).each_with_object([]) do |row, assignments|
        loan = AffirmLoanProcessor::Model::Loan.new(id: row['id'].to_i,
          amount: row['amount'].to_i,
          interest_rate: row['interest_rate'].to_f,
          default_likelihood: row['default_likelihood'].to_f,
          state: row['state']
        )
        loan_service = Service::LoanService.new(loan: loan)

        assignments.push({facility_id: loan_service.facility&.id, loan_id: loan.id})
      end
    end
  end
end
