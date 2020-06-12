# frozen_string_literal: true

require 'spec_helper'

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
      context 'When escape character' do
        ['"'].each do |ec|
          let(:command) { ec }
          it { is_expected.to be_validate }
        end
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
      context 'When include execute command' do
        let(:command) { '/bin/$(mkdir file)/command' }
        it { is_expected.to_not be_validate }
      end
      context 'When linefeed' do
        ["\r\n", "\r", "\n"].each do |rn|
          let(:command) { rn }
          it { is_expected.to_not be_validate }
        end
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
        context 'when current path' do
          let(:command) { './command' }
          let(:result)  { './command' }
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
        context 'include double quote' do
          let(:command) { 'left"center"right' }
          let(:result)  { 'left\"center\"right' }
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
