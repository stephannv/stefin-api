require 'rails_helper'

RSpec.describe FindUserByCredentials, type: :mutation do
  describe '#execute' do
    let!(:user) { create(:user) }

    context 'when email isn`t found' do
      let(:result) { described_class.run!(email: 'someemail@mail.com', password: '123456') }

      it 'returns user with given id' do
        expect(result).to be_nil
      end
    end

    context 'when email is found' do
      context 'when password is incorrect' do
        let(:result) { described_class.run!(email: user.email, password: 'incorrect-password') }

        it 'returns nil' do
          expect(result).to be_falsey
        end
      end

      context 'when password is correct' do
        let(:result) { described_class.run!(email: user.email, password: '123456') }

        it 'returns a user' do
          expect(result).to eq user
        end
      end
    end
  end
end
