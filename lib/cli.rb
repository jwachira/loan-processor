class CLI
  def call
    input_path  = ARGV.shift || './data/loans.csv'
    output_path = ARGV.shift || './assignments_output.csv'

    puts "Process loans #{input_path}".freeze

    loan_processor = AffirmLoanProcessor::LoanProcessor.new(input_path)
    assignments = loan_processor.process!

    puts "Generate loan assignments"
    # binding.pry

    CSV.open(output_path, "wb") do |csv|
      keys = assignments.first.keys
      csv << assignments.first.keys
      assignments.each do |assignment|
        csv << assignment.values_at(*keys)
      end
    end

    puts "Done generating loan assignments#{output_path}"

    # puts "Generate yields"
    # puts "Done generating yields"
  end
end
