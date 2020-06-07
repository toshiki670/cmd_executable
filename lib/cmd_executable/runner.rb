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

require 'cmd_executable'
require 'thor'

module CmdExecutable
  # CLI Runner
  #
  # Usage on CLI:
  #   $ cmd_executable ls
  #   > OK
  class Runner < Thor
    include CmdExecutable

    map '-c' => :check

    desc "-c [/path/to/command]", "It's return true if given command usable on Linux."
    def check(command = '')
      if executable?(command)
        STDOUT.puts "OK"
        exit 0
      else
        STDERR.puts "NOT FOUND"
        exit 1
      end
    end

    map %w(-v --version) => :version
    desc '-v --version', 'Show version.'
    def version
      STDOUT.puts CmdExecutable::VERSION
    end
  end
end
