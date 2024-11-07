class OrderItem < ApplicationRecord
  # Validations
  validates :order, :product, :quantity, :unit_price, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  # Associations
  belongs_to :order
  belongs_to :product

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "order_id", "product_id", "quantity", "unit_price", "updated_at"]
  end
end
