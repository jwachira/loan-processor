class CLI
  def call
    input_path  = ARGV.shift || './data/loans.csv'
    assignments_file_path = ARGV.shift || './assignments.csv'
    yields_file_path = ARGV.shift || './yields.csv'

    puts "Process loans #{input_path}".freeze

    loan_processor = AffirmLoanProcessor::LoanProcessor.new(input_path)
    yields, assignments = loan_processor.process!

    puts "Generate loan assignments"
    CSV.open(assignments_file_path, "wb") do |csv|
      keys = assignments.first.keys
      csv << assignments.first.keys
      assignments.each do |assignment|
        csv << assignment.values_at(*keys)
      end
    end
    puts "Done generating loan assignments#{assignments_file_path}"

    puts "Generate yields"
    CSV.open(yields_file_path, "wb") do |csv|
      keys = assignments.first.keys
      csv << assignments.first.keys
      assignments.each do |assignment|
        csv << assignment.values_at(*keys)
      end
    end
    puts "Done generating yields #{yields_file_path}"
  end
end
