Bundler.require :default, :test
require 'capybara/rspec'
require_relative '../sports_ladder'

Capybara.app = SportsLadder

ActiveRecord::Base.logger = Logger.new(STDOUT)

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end



