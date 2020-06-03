# frozen_string_literal: true

RSpec.describe CmdExecutable do
  it 'has a version number' do
    expect(CmdExecutable::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
