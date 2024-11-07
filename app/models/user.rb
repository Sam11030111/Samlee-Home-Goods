class User < ApplicationRecord
  # Validations
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :isAdmin, inclusion: { in: [true, false] }

  # Associations
  has_one_attached :image
  has_many :orders
  has_many :reviews
end
