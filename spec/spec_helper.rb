require "bundler/setup"
require_relative "../lib/lastpassify/runner"
# require_relative "../lib/lastpassify/lastpassify"
require "aruba/rspec"
require "aruba/api"
require "aruba/processes/in_process"

RSpec.configure do |config|
  config.include Aruba::Api
  Aruba::Processes::InProcess.main_class = LastPassify::Runner
  Aruba.process = Aruba::Processes::InProcess

  config.before(:each) do
    @aruba_io_wait_seconds = 1

    restore_env
    # clean_current_dir
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = true
  config.order = :random

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  Kernel.srand config.seed
end
