class Order < ApplicationRecord
  # Validations
  validates :user, presence: true
  validates :status, presence: true
  validates :total_price, numericality: { greater_than: 0 }

  # Associations
  belongs_to :user
  has_many :order_items
end
