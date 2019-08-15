require 'rails_helper'

RSpec.describe Subcategory, type: :model do
  describe 'Columns' do
    it { is_expected.to have_db_column(:category_id).of_type(:uuid).with_options(null: false) }
    it { is_expected.to have_db_column(:name).of_type(:citext).with_options(null: false) }
    it { is_expected.to have_db_column(:icon).of_type(:string) }
  end

  describe 'Indexes' do
    it { is_expected.to have_db_index(:category_id) }
    it { is_expected.to have_db_index(%i[category_id name]).unique(true) }
  end

  describe 'Relations' do
    it { is_expected.to belong_to(:category) }

    it { is_expected.to have_many(:records).dependent(:destroy) }
  end

  describe 'Validations' do
    subject { build(:subcategory) }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_uniqueness_of(:name).case_insensitive.scoped_to(:category_id) }

    it { is_expected.to validate_length_of(:name).is_at_most(32) }
    it { is_expected.to validate_length_of(:icon).is_at_most(32) }
  end
end
