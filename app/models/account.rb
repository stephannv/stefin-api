class Account < ApplicationRecord
  has_many :records, dependent: :destroy

  monetize :balance_cents

  validates :name, presence: true
  validates :color, presence: true
  validates :balance_cents, presence: true
  validates :balance_currency, presence: true

  validates :name, uniqueness: { case_sensitive: false }

  validates :name, length: { maximum: 255 }

  validates :color, format: { with: Utils::Color::HEX_COLOR_REGEX }
end
