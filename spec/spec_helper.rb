require 'bundler/setup'
Bundler.setup

if ENV['CI']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'factory_girl'
require 'steam_club_api'
require 'webmock/rspec'
require 'pry'

SPEC_ROOT = File.dirname(__FILE__)

Dir[File.join(SPEC_ROOT, 'support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  FactoryGirl.definition_file_paths << Pathname.new('factories')
  FactoryGirl.find_definitions

  config.include FactoryGirl::Syntax::Methods
  config.include SpecUtils
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.default_formatter = 'progress'

  # Configure webmock:
  WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  # config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect

    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended.
    mocks.verify_partial_doubles = true
  end
end
