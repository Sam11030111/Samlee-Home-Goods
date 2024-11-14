class OrderItem < ApplicationRecord
  # Validations
  validates :order, :product, :quantity, :unit_price, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }

  # Associations
  belongs_to :order
  belongs_to :product

  after_save :update_order_total_price
  after_destroy :update_order_total_price

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "order_id", "product_id", "quantity", "unit_price", "updated_at"]
  end

  private

  def update_order_total_price
    # Recalculate total_price only for pending orders
    if order.status == 'pending'
      order_total_price = order.order_items.sum { |item| item.quantity * item.unit_price }
      order.update(total_price: order_total_price)

      # Delete the order if total_price is zero and no order_items remain
      order.destroy if order_total_price.zero? && order.order_items.empty?
    end
  end
end
