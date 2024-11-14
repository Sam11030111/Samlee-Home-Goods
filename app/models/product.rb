class Product < ApplicationRecord
  # Validations
  validates :name, :description, :price, :stock, :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  # Associations
  has_one_attached :image
  belongs_to :category
  has_many :reviews
  has_many :order_items
  has_many :orders, through: :order_items

  after_update :update_pending_orders, if: :saved_change_to_price?

  # Calculate average rating of the product
  def average_rating
    reviews.average(:rating).to_f.round(1) # Calculate and round to 1 decimal place
  end

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "name", "price", "stock", "category_id", "updated_at", "image"]
  end

  private

  def update_pending_orders
    # Find all pending order items associated with this product
    order_items.joins(:order).where(orders: { status: 'pending' }).find_each do |order_item|
      # Update unit_price of the order item
      order_item.update(unit_price: price)

      # Recalculate the total price for the order
      order = order_item.order
      order_total_price = order.order_items.sum { |item| item.quantity * item.unit_price }
      order.update(total_price: order_total_price)
    end
  end
end
