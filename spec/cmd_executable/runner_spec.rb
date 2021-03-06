# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CmdExecutable::Runner do
  describe '#check' do
    context 'When success' do
      subject { capture_stdout { CmdExecutable::Runner.start(%w[-c ls]) } }
      it { is_expected.to match(/OK/) }
      it { expect(subject.yield_self { $CHILD_STATUS }).to be_success }
    end
    context 'When failed' do
      subject { capture_stdout { CmdExecutable::Runner.start(%w[-c hoge_invalid]) } }
      it { is_expected.to match(/NOT FOUND/) }
      it { expect(subject.yield_self { $CHILD_STATUS }).not_to be_success }
    end
    context 'When error' do
      subject { capture_stderr { CmdExecutable::Runner.start(%w[-c /path/to/$(ls)/command]) } }
      it { is_expected.to match(/Invalid command:/) }
      it { is_expected.to match(%r{`/path/to/\$\(ls\)/command'}) }
      it { expect(subject.yield_self { $CHILD_STATUS }).not_to be_success }
    end
  end

  describe '#version' do
    subject { capture_stdout { CmdExecutable::Runner.start(%w[-v]) } }
    it { is_expected.to match(/#{CmdExecutable::VERSION}/) }
  end
end
