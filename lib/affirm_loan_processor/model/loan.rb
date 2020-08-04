module AffirmLoanProcessor
  module Model
    class Loan
      attr_accessor :id, :amount, :interest_rate, :default_likelihood, :state

      def initialize(id:, amount:, interest_rate:, default_likelihood:, state:)
        @id = id
        @amount = amount.to_i
        @interest_rate = interest_rate.to_f
        @default_likelihood = default_likelihood.to_f
        @state  = state
      end

      def self.expected_yield(facility, loan)
        interest_charged_by_facility = facility.interest_rate * loan.amount
        loan.interest - loan.default_cost - interest_charged_by_facility
      end

      def interest
        (1-default_likelihood) * interest_rate * amount
      end

      def default_cost
        default_likelihood * amount
      end
    end
  end
end
