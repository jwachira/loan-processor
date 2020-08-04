module AffirmLoanProcessor
  module Model
    class Bank
      DATA_SOURCE = './data/banks.csv'
      attr_accessor :id, :name

      def initialize(id:, name:)
        @id = id
        @name = name
      end

      def self.all
        banks ||= CSV.foreach(DATA_SOURCE, headers: true).each_with_object({}) do |row, banks|
          banks[row['id']] = Bank.new(id: row['id'], name: row['name'])
        end
      end
    end
  end
end
