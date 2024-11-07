# db/seeds.rb
require 'faker'

# Create categories
categories = []
5.times do
  categories << Category.create!(name: Faker::Commerce.department)
end

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

# Create products (Make sure not to exceed 200 total records)
products = []
30.times do
  products << Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price(range: 10..100.0),
    stock: Faker::Number.between(from: 1, to: 100),
    category: categories.sample
  )
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
30.times do
  reviews << Review.create!(
    user: users.sample,
    product: products.sample,
    rating: Faker::Number.between(from: 1, to: 5),
    comment: Faker::Lorem.sentence
  )
end

puts "Seeding completed!"
