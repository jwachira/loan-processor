#!/usr/bin/env ruby
require "bundler/setup"
require "./lib/affirm_loan_processor"
require "./lib/cli"

CLI.new.call
