class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true

  validates :email, uniqueness: true

  validates :name, length: { maximum: 128 }
  validates :email, length: { maximum: 128 }
  validates :password, length: { minimum: 6 }
end
