class AddSubcategoryIdToRecords < ActiveRecord::Migration[6.0]
  def change
    # rubocop:disable Rails/NotNullColumn
    add_reference :records, :subcategory, null: false, foreign_key: true, type: :uuid, index: true
    # rubocop:enable Rails/NotNullColumn
  end
end
