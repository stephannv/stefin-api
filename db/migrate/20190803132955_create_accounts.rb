class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.citext :name, null: false, index: { unique: true }
      t.monetize :balance, amount: { default: 0, limit: 8 }
      t.string :color, null: false, limit: 7

      t.timestamps
    end
  end
end
