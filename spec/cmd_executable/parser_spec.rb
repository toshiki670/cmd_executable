# frozen_string_literal: true

require 'cmd_executable/parser'

# rubocop:disable Metrics/BlockLength

RSpec.describe CmdExecutable::Parser do
  let(:instance) { CmdExecutable::Parser.new(command) }

  describe '#validate?' do
    subject { instance }

    describe 'Success' do
      context 'When String' do
        let(:command) { '/bin/ls' }
        it { is_expected.to be_validate }
      end
      context 'When Symbol' do
        let(:command) { :ls }
        it { is_expected.to be_validate }
      end
    end

    describe 'Failure' do
      context 'When empty command' do
        let(:command) { '' }
        it { is_expected.to_not be_validate }
      end
      context 'When nil command' do
        let(:command) { nil }
        it { is_expected.to_not be_validate }
      end
      context 'When no string' do
        let(:command) { 10 }
        it { is_expected.to_not be_validate }
      end
    end
  end

  describe '#command' do
    describe 'Success' do
      subject { instance.command }

      context 'When absolute' do
        context 'path only' do
          let(:command) { '/bin/ls' }
          let(:result)  { '/bin/ls' }
          it { is_expected.to eq result }
        end
        context 'path with options' do
          let(:command) { '/bin/ls -la' }
          let(:result)  { '/bin/ls' }
          it { is_expected.to eq result }
        end
        context 'path without command' do
          let(:command) { '/bin/' }
          let(:result)  { '/bin/' }
          it { is_expected.to eq result }
        end
      end

      context 'When relative' do
        context 'path only' do
          let(:command) { '../../bin/ls' }
          let(:result)  { '../../bin/ls' }
          it { is_expected.to eq result }
        end
        context 'path with options' do
          let(:command) { '../../bin/ls -la' }
          let(:result)  { '../../bin/ls' }
          it { is_expected.to eq result }
        end
        context 'path without command' do
          let(:command) { '../../bin/' }
          let(:result)  { '../../bin/' }
          it { is_expected.to eq result }
        end
      end

      context 'When command' do
        context 'only' do
          let(:command) { 'ls' }
          let(:result)  { 'ls' }
          it { is_expected.to eq result }
        end
        context 'with options' do
          let(:command) { 'ls -la' }
          let(:result)  { 'ls' }
          it { is_expected.to eq result }
        end
        context 'by Symbol' do
          let(:command) { :ls }
          let(:result)  { 'ls' }
          it { is_expected.to eq result }
        end
      end
    end

    describe 'Exception' do
      subject { -> { instance.command } }

      context 'When empty command' do
        let(:command) { '' }
        it { is_expected.to raise_error(CmdExecutable::ParserError) }
      end
      context 'When nil command' do
        let(:command) { nil }
        it { is_expected.to raise_error(CmdExecutable::ParserError) }
      end
      context 'When no string' do
        let(:command) { 10 }
        it { is_expected.to raise_error(CmdExecutable::ParserError) }
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
