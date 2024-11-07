class OrderItem < ApplicationRecord
  # Validations
  validates :order, :product, :quantity, :unit_price, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price, numericality: { greater_than: 0 }

  # Associations
  belongs_to :order
  belongs_to :product
end
