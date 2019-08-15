class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy

  validates :name, presence: true
  validates :color, presence: true

  validates :name, uniqueness: { case_sensitive: false }

  validates :name, length: { maximum: 32 }
  validates :icon, length: { maximum: 32 }

  validates :color, format: { with: Utils::Color::HEX_COLOR_REGEX }
end
