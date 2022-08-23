# frozen_string_literal: true

RSpec.describe Pwush::Message do
  subject(:message) { described_class }

  let(:default_attributes) do
    {
      send_date: 'now',
      ignore_user_timezone: true
    }
  end

  context 'with no attributes' do
    it 'raises error' do
      expect { message.new }.to raise_error(Dry::Struct::Error)
    end
  end

  context 'default attributes' do
    let(:attributes) do
      {
        content: '!'
      }
    end
    it 'inits with default values' do
      expect(message.new(attributes).__attributes__).to eq(
        default_attributes.merge(attributes)
      )
    end
  end
end
