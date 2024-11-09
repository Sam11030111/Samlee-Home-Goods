class User < ApplicationRecord
  # Enable bcrypt password hashing
  has_secure_password

  # Validations
  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :isAdmin, inclusion: { in: [true, false] }

  # Associations
  has_one_attached :image
  has_many :orders
  has_many :reviews
  
  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "first_name", "last_name", "email", "password", "isAdmin", "image", "updated_at"]
  end
end
