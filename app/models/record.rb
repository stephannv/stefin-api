class Record < ApplicationRecord
  belongs_to :account
  belongs_to :subcategory

  as_enum :group, { expense: -1, income: 1 }, source: :group_modifier

  monetize :amount_cents

  validates :account_id, presence: true
  validates :occurred_at, presence: true
  validates :amount_cents, presence: true
  validates :amount_currency, presence: true
  validates :group_modifier, presence: true

  validates :amount_cents, numericality: { greater_than: 0 }

  validates :title, length: { maximum: 255 }
  validates :description, length: { maximum: 8192 }
end
