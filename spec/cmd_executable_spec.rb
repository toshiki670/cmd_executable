# frozen_string_literal: true

require 'cmd_executable'

RSpec.describe CmdExecutable do
  class Klass
    include CmdExecutable
  end
  let(:instance) { Klass.new }

  describe '#executable?' do
    describe 'Success' do
      subject { instance }
      context 'With absolute path' do
        let(:command) { '/bin/ls' }
        it { is_expected.to be_executable command }
      end
      context 'With invalid absolute path' do
        let(:command) { '/bin/hoge_invalid' }
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
      # context 'When symbol' do
      #   let(:command) { :ls }
      #   it { is_expected.to_not be_executable command }
      # end
    end

    describe 'Exception' do
      subject { -> { instance.executable?(command) } }
      context 'When empty command' do
        let(:command) { '' }
        it { is_expected.to raise_error(ArgumentError) }
      end
      context 'When nil command' do
        let(:command) { nil }
        it { is_expected.to raise_error(ArgumentError) }
      end
      context 'When no string' do
        let(:command) { 10 }
        it { is_expected.to raise_error(ArgumentError) }
      end
    end
  end
end
