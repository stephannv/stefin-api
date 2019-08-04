class Account < ApplicationRecord
  monetize :balance_cents

  validates :name, presence: true
  validates :color, presence: true
  validates :balance_cents, presence: true
  validates :balance_currency, presence: true

  validates :name, uniqueness: { case_sensitive: false }

  validates :name, length: { maximum: 255 }

  validates :color, format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/ }
end
