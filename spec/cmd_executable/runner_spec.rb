# frozen_string_literal: true

require 'cmd_executable/runner'
require 'English'

RSpec.describe CmdExecutable::Runner do
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

  let(:instance) { CmdExecutable::Runner.new }

  describe '#check' do
    context 'When success' do
      subject { capture(:stdout) { CmdExecutable::Runner.start(%w[-c ls]) } }
      it { is_expected.to match(/OK/) }
      it { expect(subject.yield_self { $CHILD_STATUS }).to be_success }
    end
    context 'When error' do
      subject { instance.check('hoge_invalid') }
      subject { capture(:stdout) { CmdExecutable::Runner.start(%w[-c hoge_invalid]) } }
      it { is_expected.to match(/NOT FOUND/) }
      it { expect(subject.yield_self { $CHILD_STATUS }).not_to be_success }
    end
  end

  describe '#version' do
    subject { capture(:stdout) { CmdExecutable::Runner.start(%w[-v]) } }
    it { is_expected.to match(/#{CmdExecutable::VERSION}/) }
  end
end
