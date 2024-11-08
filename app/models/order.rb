class Order < ApplicationRecord
  # Validations
  validates :user, presence: true
  validates :status, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  # Associations
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "user_id", "status", "total_price", "updated_at"]
  end
end
