# frozen_string_literal: true

require 'cmd_executable/runner'

RSpec.describe CmdExecutable::Runner do
  let(:instance) { CmdExecutable::Runner.new }

  describe '#check' do
    context 'When success' do
      subject { instance.check("ls") }
      it do
        expect { subject }.to raise_error(SystemExit) do |res|
          expect(res.status).to eq(0)
        end
      end
    end
    context 'When error' do
      subject { instance.check("hoge_invalid") }
      it do
        expect { subject }.to raise_error(SystemExit) do |res|
          expect(res.status).to eq(1)
        end
      end
    end
  end
end
