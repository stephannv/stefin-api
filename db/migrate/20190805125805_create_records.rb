class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records, id: :uuid do |t|
      t.references :account, null: false, foreign_key: true, type: :uuid, index: true
      t.monetize :amount, amount: { limit: 8 }
      t.datetime :occurred_at, null: false, index: true
      t.integer :group_modifier, null: false, index: true
      t.string :title, limit: 255
      t.text :description

      t.timestamps
    end
  end
end
