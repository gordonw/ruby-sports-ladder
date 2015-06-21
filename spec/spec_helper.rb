
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents mocking or stubbing a method that does not exist on a real object.
    mocks.verify_partial_doubles = true
  end

  # config.warnings = true

  config.order = :random

  Kernel.srand config.seed

end
