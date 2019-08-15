class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.citext :name, null: false, index: { unique: true }
      t.string :icon, limit: 32
      t.string :color, null: false, limit: 7

      t.timestamps
    end
  end
end
