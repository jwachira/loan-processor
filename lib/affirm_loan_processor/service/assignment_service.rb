module AffirmLoanProcessor
  module Service
    class AssignmentService
      attr_accessor :loan_id, :facility_id
      def initialize(loan_id:, facility_id:)
        @loan_id = loan_id
        @facility_id = facility_id
      end
    end
  end
end
