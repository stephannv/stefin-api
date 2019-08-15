class CreateSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :subcategories, id: :uuid do |t|
      t.references :category, null: false, foreign_key: true, type: :uuid, index: true
      t.citext :name, null: false
      t.string :icon, limit: 32

      t.timestamps
    end

    add_index :subcategories, %i[category_id name], unique: true
  end
end
