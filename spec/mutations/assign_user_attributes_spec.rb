require 'rails_helper'

RSpec.describe AssignUserAttributes, type: :mutation do
  describe '#execute' do
    let(:user) { User.new }
    let(:attributes) { attributes_for(:user) }

    it 'assigns attributes to given user' do
      described_class.run!(user: user, attributes: attributes)
      expect(user.attributes.slice('name', 'email').symbolize_keys).to eq attributes.slice(:name, :email)
    end
  end
end
