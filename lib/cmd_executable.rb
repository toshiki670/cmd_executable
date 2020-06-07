# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright (c) 2020 Toshiki
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'English'
require 'cmd_executable/parser'
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
    parsed = CmdExecutable::Parser.new(command)
    raise ArgumentError unless parsed.validate?

    `type '#{parsed.command}' > /dev/null 2>&1`.yield_self do
      $CHILD_STATUS.success?
    end
  end
end
