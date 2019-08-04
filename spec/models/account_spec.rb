require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'Columns' do
    it { is_expected.to have_db_column(:name).of_type(:citext).with_options(null: false) }
    it { is_expected.to have_db_column(:color).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:balance_cents).of_type(:integer).with_options(default: 0, null: false) }
    it { is_expected.to have_db_column(:balance_currency).of_type(:string).with_options(null: false) }
  end

  describe 'Index' do
    it { is_expected.to have_db_index(:name).unique(true) }
  end

  describe 'Configuration' do
    it { is_expected.to monetize(:balance) }
  end

  describe 'Validations' do
    subject { build(:account) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:balance_cents) }
    it { is_expected.to validate_presence_of(:balance_currency) }
    it { is_expected.to validate_presence_of(:color) }

    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    it { is_expected.to validate_length_of(:name).is_at_most(255) }

    it { is_expected.to allow_values('#FF0099', '#AACC11', '#FFF', '#000').for(:color) }
    it { is_expected.to_not allow_values('FF0099', '#GG0000', '#FFFF', '#GGG', '_000000', '_000').for(:color) }
  end
end
