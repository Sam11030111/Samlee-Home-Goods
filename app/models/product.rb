class Product < ApplicationRecord
  # Validations
  validates :name, :description, :price, :stock, :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  # Associations
  has_one_attached :image
  belongs_to :category
  has_many :order_items
  has_many :reviews

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "name", "price", "stock", "category_id", "updated_at", "image"]
  end
end
