require 'pry'
require 'csv'
require "affirm_loan_processor/version"
#MODELS
require './lib/affirm_loan_processor/model/bank'
require './lib/affirm_loan_processor/model/covenant'
require './lib/affirm_loan_processor/model/facility'
require './lib/affirm_loan_processor/model/loan'

#SERVICES
require './lib/affirm_loan_processor/service/assignment_service'
require './lib/affirm_loan_processor/service/loan_service'

require './lib/affirm_loan_processor/loan_processor'

module AffirmLoanProcessor
  class Error < StandardError; end
end
