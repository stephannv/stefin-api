require 'rails_helper'

RSpec.describe SaveUser, type: :mutation do
  describe '#execute' do
    let(:user) { build(:user) }

    context 'when given attributes are valid' do
      it 'creates a new user with given attributes' do
        expect(user).to be_a_new(User)
        described_class.run!(user: user)
        expect(user).to be_persisted
      end
    end

    context 'when given attributes are invalid' do
      it 'raises ActiveRecord::RecordInvalid error' do
        expect { described_class.run!(user: User.new) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
