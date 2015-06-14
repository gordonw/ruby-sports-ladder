require_relative  '../poolLadder'

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.app = Sinatra::Application