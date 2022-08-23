# frozen_string_literal: true

RSpec.describe Pwush::Config do
  subject(:config) { described_class }

  it 'must contain auth attribute' do
    expect { config.new(auth: nil, app: 'QWtasg3') }.to raise_error(
      Pwush::MissingAuthToken
    )
  end

  it 'must contain app attribute' do
    expect { config.new(auth: 'qweasgg', app: nil) }.to raise_error(
      Pwush::MissingAppToken
    )
  end

  it 'has default pushwoosh url' do
    cfg = config.new(app: 'aasf', auth: 'sdg3')
    expect(cfg.url).to eq('https://cp.pushwoosh.com/json/1.3')
  end
end
