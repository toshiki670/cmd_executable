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

module CmdExecutable
  class ParserError < StandardError; end

  # Parser for CmdExecutable
  class Parser
    attr_reader :raw

    def initialize(raw)
      @raw = raw
      @raw.freeze
    end

    def validate?
      !@raw.nil? &&
        command_class_validate? &&
        !@raw.empty? &&
        !include_invalid_char?
    end

    def command
      parse if @command.nil?
      @command
    end

    private

    def command_class_validate?
      @raw.is_a?(String) ||
        @raw.is_a?(Symbol)
    end

    def include_invalid_char?
      @raw.match?(/\r\n|\r|\n/) ||
        @raw.match?(/\$\(.*\)/)
    end

    def parse
      raise CmdExecutable::ParserError, @raw unless validate?

      path = escape_char(@raw.to_s.chomp)
      @dirname = parse_dirname(path)
      @basename = parse_basename(path)
      @command = @dirname + @basename
      self
    end

    def no_separator_at_the_right_end_regex
      /(?<!#{File::SEPARATOR})\Z/
    end

    def a_dot_only_regex
      /\A\.\Z/
    end

    def current_path_at_the_left_regex
      /\A\.#{File::SEPARATOR}/
    end

    def basename_exist?(path)
      path.match?(no_separator_at_the_right_end_regex)
    end

    def no_right_separator_exists?(dir)
      dir.match?(no_separator_at_the_right_end_regex)
    end

    def current_path?(path)
      path.match?(current_path_at_the_left_regex)
    end

    def parse_dirname(path)
      return path unless basename_exist?(path)

      dir = File.dirname(path)
      return '' if dir.match?(a_dot_only_regex) && !current_path?(path)

      no_right_separator_exists?(dir) ? (dir + File::SEPARATOR) : dir
    end

    def parse_basename(path)
      return '' unless basename_exist?(path)

      File.basename(path).split.first
    end

    def escape_char(path)
      path.gsub(/"/, '\"')
    end
  end
end
