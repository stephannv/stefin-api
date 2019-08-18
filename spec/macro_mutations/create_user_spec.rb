require 'rails_helper'

RSpec.describe CreateUser, type: :macro_mutation do
  describe '#execute' do
    let(:user_attributes) { attributes_for(:user) }
    let(:user) { described_class.run!(user_attributes: user_attributes) }

    it 'creates a new user with given attributes' do
      expect(user).to be_persisted
      expect(user.name).to eq user_attributes[:name]
      expect(user.email).to eq user_attributes[:email]
      expect(user.password).to eq user_attributes[:password]
    end
  end
end
