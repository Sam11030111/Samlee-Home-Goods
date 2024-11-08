require 'open-uri'
require 'json'

# Clear existing data
OrderItem.destroy_all
Order.destroy_all
Review.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all

# Create categories from Fake Store API
categories_data = JSON.parse(URI.open('https://fakestoreapi.com/products').read).map { |product| product['category'] }.uniq
categories = categories_data.map { |category_name| Category.create!(name: category_name) }

# Create users
users = []
5.times do
  users << User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: 'password',
    isAdmin: [true, false].sample
  )
end

# Create products from Fake Store API
products_data = JSON.parse(URI.open('https://fakestoreapi.com/products').read)
products = products_data.map do |product_data|
  # Find the corresponding category
  category = categories.find { |cat| cat.name == product_data['category'] }

  # Create the product with the image URL
  product = Product.create!(
    name: product_data['title'],
    description: product_data['description'],
    price: product_data['price'],
    stock: Faker::Number.between(from: 1, to: 100),
    category: category,
  )

  # Download and attach the image
  image_url = product_data['image']
  downloaded_image = URI.open(image_url)
  product.image.attach(io: downloaded_image, filename: "product_#{product.id}.jpg", content_type: 'image/jpeg')
  
  product
end

# Create orders
orders = []
20.times do
  orders << Order.create!(
    user: users.sample,
    status: ['pending', 'completed', 'shipped'].sample,
    total_price: Faker::Commerce.price(range: 20..500.0)
  )
end

# Create order items
order_items = []
50.times do
  order_items << OrderItem.create!(
    order: orders.sample,
    product: products.sample,
    quantity: Faker::Number.between(from: 1, to: 5),
    unit_price: Faker::Commerce.price(range: 10..100.0)
  )
end

# Create reviews
reviews = []
20.times do
  reviews << Review.create!(
    user: users.sample,
    product: products.sample,
    rating: Faker::Number.between(from: 1, to: 5),
    comment: Faker::Lorem.sentence
  )
end

puts "Seeding completed!"
