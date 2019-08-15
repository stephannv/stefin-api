require 'rails_helper'

RSpec.describe Utils::Color, type: :extensions do
  describe '::HEX_COLOR_REGEX' do
    it 'returns regex for a valid hex color code' do
      expect(described_class::HEX_COLOR_REGEX).to eq(/\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/)
    end
  end
end
