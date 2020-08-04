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
    end
  end
end
