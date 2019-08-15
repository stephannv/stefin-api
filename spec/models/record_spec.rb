require 'rails_helper'

RSpec.describe Record, type: :model do
  describe 'Columns' do
    it { is_expected.to have_db_column(:account_id).of_type(:uuid).with_options(null: false) }
    it { is_expected.to have_db_column(:subcategory_id).of_type(:uuid).with_options(null: false) }
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(limit: 255) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:occurred_at).of_type(:datetime).with_options(null: false) }

    it do
      is_expected.to have_db_column(:amount_cents).of_type(:integer).with_options(default: 0, null: false, limit: 8)
    end

    it { is_expected.to have_db_column(:amount_currency).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:group_modifier).of_type(:integer).with_options(null: false) }
  end

  describe 'Indexes' do
    it { is_expected.to have_db_index(:account_id) }
    it { is_expected.to have_db_index(:subcategory_id) }
    it { is_expected.to have_db_index(:occurred_at) }
    it { is_expected.to have_db_index(:group_modifier) }
  end

  describe 'Relations' do
    it { is_expected.to belong_to(:account) }
    it { is_expected.to belong_to(:subcategory) }
  end

  describe 'Configurations' do
    it { is_expected.to monetize(:amount) }

    it 'has group enum' do
      expect(described_class.groups.hash).to eq('expense' => -1, 'income' => 1)
    end
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:account_id) }
    it { is_expected.to validate_presence_of(:occurred_at) }
    it { is_expected.to validate_presence_of(:amount_cents) }
    it { is_expected.to validate_presence_of(:amount_currency) }
    it { is_expected.to validate_presence_of(:group_modifier) }

    it { is_expected.to validate_numericality_of(:amount_cents).is_greater_than(0) }

    it { is_expected.to validate_length_of(:title).is_at_most(255) }
    it { is_expected.to validate_length_of(:description).is_at_most(8192) }
  end
end
