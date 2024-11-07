class Product < ApplicationRecord
  # Validations
  validates :name, :description, :price, :stock, :category, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  # Associations
  has_one_attached :image
  belongs_to :category
  has_many :order_items
  has_many :reviews
end
