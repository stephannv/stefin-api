class Subcategory < ApplicationRecord
  belongs_to :category

  has_many :records, dependent: :destroy

  validates :name, presence: true

  validates :name, uniqueness: { case_sensitive: false, scope: :category_id }

  validates :name, length: { maximum: 32 }
  validates :icon, length: { maximum: 32 }
end
