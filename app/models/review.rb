class Review < ApplicationRecord
   # Validations
   validates :user, :product, :rating, presence: true
   validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
   validates :comment, length: { maximum: 500 }, allow_nil: true
 
   # Associations
   belongs_to :user
   belongs_to :product

   def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob"]
   end

   def self.ransackable_attributes(auth_object = nil)
    ["created_at", "user_id", "product_id", "rating", "comment", "updated_at"]
   end
end
