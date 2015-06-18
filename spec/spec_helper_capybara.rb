require_relative  '../poolLadder'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

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

Capybara.app = Sinatra::Application

