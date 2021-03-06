# frozen_string_literal: true

require 'bundler/setup'
require 'English'
require 'cmd_executable'
require 'cmd_executable/parser'
require 'cmd_executable/runner'
require 'cmd_executable/version'

require 'stream_capture'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include StreamCapture
end
