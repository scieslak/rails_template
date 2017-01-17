require 'simplecov'
require "codeclimate-test-reporter"

# To perform coverage test run:
# COVERAGE=true rails test
if ENV["COVERAGE"]

  SimpleCov.start 'rails' do
    add_filter "/config/"
    add_filter "/test/"
  end

  ENV['CODECLIMATE_REPO_TOKEN'] = ENV['CODECLIMATE_TRAVIS_PLAY']
  CodeClimate::TestReporter.start

end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# require 'capybara/rails'
# class ActionDispatch::IntegrationTest
#   include Capybara::DSL
#   def teardown
#     Capybara.reset_sessions!
#     Capybara.use_default_driver
#   end
# end
