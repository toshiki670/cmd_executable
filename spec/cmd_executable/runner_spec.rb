# frozen_string_literal: true

require 'cmd_executable/runner'

RSpec.describe CmdExecutable::Runner do
  let(:instance) { CmdExecutable::Runner.new }

  describe '#cmd_executable' do
    subject { instance }
    context do
      it { is_expected.to be_truthy }
    end
  end
end
