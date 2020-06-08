# frozen_string_literal: true

module StreamCapture
  # rubocop:disable Security/Eval, Metrics/MethodLength
  def capture(stream)
    begin
      stream = stream.to_s
      binding.eval("$#{stream} = StringIO.new", __FILE__, __LINE__)
      yield
    rescue SystemExit => e
      puts e.status
    ensure
      result = binding.eval("$#{stream}", __FILE__, __LINE__).string
      binding.eval("$#{stream} = #{stream.upcase}", __FILE__, __LINE__)
    end
    result
  end
  # rubocop:enable Security/Eval, Metrics/MethodLength

  def capture_stdout
    capture(:stdout)
  end

  def capture_stderr
    capture(:stderr)
  end
end
