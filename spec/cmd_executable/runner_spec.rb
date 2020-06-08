# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CmdExecutable::Runner do
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
