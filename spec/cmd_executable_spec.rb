# frozen_string_literal: true

RSpec.describe CmdExecutable do
  class Klass
    include CmdExecutable
  end
  let(:instance) { Klass.new }

  describe '#executable?' do
    subject { instance }
    context 'With absolute path' do
      let(:command) { '/usr/sbin/ls' }
      it { is_expected.to be_executable command }
    end
    context 'With invalid absolute path' do
      let(:command) { '/usr/sbin/hoge_invalid' }
      it { is_expected.to_not be_executable command }
    end
    context 'Without path' do
      let(:command) { 'ls' }
      it { is_expected.to be_executable command }
    end
    context 'When invalid command' do
      let(:command) { 'hoge_invalid' }
      it { is_expected.to_not be_executable command }
    end
  end
end
