# frozen_string_literal: true

require 'English'
require 'cmd_executable/version'

# Command Executable
#
# Usage:
#   require 'cmd_executable'
#
#   class Klass
#     include 'CmdExecutable'
#
#     def instance_method
#       executable?('ls')
#     end
#   end
module CmdExecutable
  class CmdExecutableError < StandardError; end

  def executable?(command)
    path = File.split(command).yield_self do |dirname, basename|
      dirname = File.absolute_path?(dirname) ? dirname : ''
      dirname += File::SEPARATOR if dirname.rindex(File::SEPARATOR)
      dirname + basename.split.first
    end

    `type '#{path}' > /dev/null 2>&1`.yield_self do
      $CHILD_STATUS.success?
    end
  end
end
