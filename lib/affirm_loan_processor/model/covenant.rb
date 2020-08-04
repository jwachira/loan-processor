module AffirmLoanProcessor
  module Model
    class Covenant
      DATA_SOURCE = './data/covenants.csv'.freeze
      attr_accessor :bank_id, :facility_id, :max_default_likelihood, :banned_state

      def initialize(facility_id:, bank_id:, max_default_likelihood:, banned_state:)
        @facility_id = facility_id
        @bank_id = bank_id
        @max_default_likelihood = max_default_likelihood
        @banned_state = banned_state
      end

      def self.all
        covenants ||=
          ::CSV.foreach(DATA_SOURCE, headers: true).each_with_object({}) do |row, covenants|
            (covenants[row['facility_id'].to_i] ||= []) <<
              Covenant.new(facility_id: row['facility_id'].to_i,
                           bank_id: row['bank_id'].to_i,
                           max_default_likelihood: row['max_default_likelihood'],
                           banned_state: row['banned_state'])
          end
      end

      def self.find_by_facility_id(facility_id)
        covenants ||= all[facility_id]
      end

      def self.requirements_met?(facility_id, loan)
        facility_covenants = find_by_facility_id(facility_id)

        return false unless facility_covenants
        return facility_covenants.any? do |covenant|
          covenant.banned_state != loan.state &&
            (covenant.max_default_likelihood.nil? ||
              covenant.max_default_likelihood.to_f >= loan.default_likelihood.to_f)
        end

        false
      end
    end
  end
end
