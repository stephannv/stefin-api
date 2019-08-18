require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Columns' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false, limit: 128) }
    it { is_expected.to have_db_column(:email).of_type(:citext).with_options(null: false) }
    it { is_expected.to have_db_column(:password_digest).of_type(:string).with_options(null: false) }
  end

  describe 'Indexes' do
    it { is_expected.to have_db_index(:email).unique(true) }
  end

  describe 'Configurations' do
    it { is_expected.to have_secure_password }
  end

  describe 'Validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password_digest) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it { is_expected.to validate_length_of(:name).is_at_most(128) }
    it { is_expected.to validate_length_of(:email).is_at_most(128) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end
end
