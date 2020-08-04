module AffirmLoanProcessor
  module Service
    class LoanService
      attr_accessor :loan

      def initialize(loan:)
        @loan = loan
        @assignment = nil
        @expected_yield = nil
      end

      def loan_assignment(facility)
        @assignment = AffirmLoanProcessor::Service::AssignmentService.new(
          facility_id: facility.id,
          loan_id: loan.id
        )
      end

      def expected_yield(facility)
        (1-loan.default_likelihood) *
          loan.interest_rate * loan.amount - loan.default_likelihood *
            loan.amount - facility.interest_rate * loan.amount
      end

      def facility
        @facility ||= AffirmLoanProcessor::Model::Facility.find_funding_facility(loan)
      end
    end
  end
end
