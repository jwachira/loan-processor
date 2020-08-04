require 'pry'
require 'csv'
require "affirm_loan_processor/version"
#MODELS
require './lib/affirm_loan_processor/model/bank'
require './lib/affirm_loan_processor/model/covenant'
require './lib/affirm_loan_processor/model/facility'
require './lib/affirm_loan_processor/model/loan'

require './lib/affirm_loan_processor/loan_processor'

module AffirmLoanProcessor
  class Error < StandardError; end
end
