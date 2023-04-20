require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: 'test@test.com', role: 'Admin', password: '111111', password_confirmation: '111111', username: 'testing', phone: '03349949490') if Rails.env.development?

Supplier.create(name: 'Supplier 2', email: 'supplier3@gmail.com', phone: '03215472014', address: 'House No 1 Supplier Society Islamabad', created_at: Time.now, updated_at: Time.now)
Supplier.create(name: 'Supplier 5', email: 'supplier5@gmail.com', phone: '03215666666', address: 'House No 4 Supplier Society Karachi', created_at: Time.now, updated_at: Time.now)
Supplier.create(name: 'Supplier 4', email: 'supplier4@gmail.com', phone: '03215555555', address: 'House No 3 Supplier Society Lahore', created_at: Time.now, updated_at: Time.now)

Brand.create(name: 'Brand 1', description:"Brand 1 Description", created_at: Time.now, updated_at: Time.now )
Brand.create(name: 'Brand 3', description:"Brand 3 Description", created_at: Time.now, updated_at: Time.now )
Brand.create(name: 'Brand 2', description:"Brand 2 Description", created_at: Time.now, updated_at: Time.now )

Category.create(name: 'Category 2', description:"Category 2 Description", created_at: Time.now, updated_at: Time.now )
Category.create(name: 'Category 1', description:"Category 1 Description", created_at: Time.now, updated_at: Time.now )
Category.create(name: 'Category 3', description:"Category 3 Description", created_at: Time.now, updated_at: Time.now )

# Seed Suppliers
Supplier.create(name: "ABC Corporation", email: "abc@example.com", phone: "+923001234567", address: "123 Main Street, Karachi, Pakistan", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Supplier.create(name: "DEF Inc", email: "def@example.com", phone: "+923041234567", address: "456 Second Street, Lahore, Pakistan", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Supplier.create(name: "GHI Enterprises", email: "ghi@example.com", phone: "+923081234567", address: "789 Third Street, Islamabad, Pakistan", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Supplier.create(name: "JKL Industries", email: "jkl@example.com", phone: "+923121234567", address: "101 Fourth Street, Rawalpindi, Pakistan", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Supplier.create(name: "MNO Trading", email: "mno@example.com", phone: "+923161234567", address: "202 Fifth Street, Peshawar, Pakistan", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# # Seed Brands
Brand.create(name: "Nike", description: "Sportswear and accessories brand", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Brand.create(name: "Adidas", description: "Sportswear and accessories brand", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Brand.create(name: "Apple", description: "Technology and electronics brand", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Brand.create(name: "Samsung", description: "Technology and electronics brand", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Brand.create(name: "Toyota", description: "Automobile brand", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Seed Categories
Category.create(name: "Men's Clothing", description: "Clothing for men", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Category.create(name: "Women's Clothing", description: "Clothing for women", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Category.create(name: "Electronics", description: "Electronic devices and accessories", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Category.create(name: "Sports Equipment", description: "Equipment for sports and fitness", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Category.create(name: "Home Appliances", description: "Appliances for home use", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

categories = Category.all
supplier = Supplier.all
brand = Brand.all

name_length_range = 5..20
description_length_range = 5..50


50.times do
  product = Product.new(
    name: Faker::Commerce.product_name.slice(0, rand(name_length_range)),
    stock: rand(1..100),
    description: Faker::Lorem.paragraph.slice(0, rand(description_length_range)),
    price: rand(10..1000),
    location_name: Faker::Address.city,
    brand_id: brand.sample.id,
    created_at: Time.now,
    updated_at: Time.now
  )

  product.categories << categories.sample(rand(1..3))
  product.suppliers << supplier.sample(rand(1..3))
  product.save
  p product
end



Order.create(consumer_name: "John Smith", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Order.create(consumer_name: "Emily Brown", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Order.create(consumer_name: "William Davis", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Order.create(consumer_name: "Jessica Garcia", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Order.create(consumer_name: "Daniel Martin", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Order.create(consumer_name: "Mia Johnson", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
Order.create(consumer_name: "Ethan Lee", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

OrderItem.create(quantity: 2, description: "Wireless Earbuds", price: 899, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 1, description: "Gaming Mouse", price: 699, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 3, description: "Bluetooth Speaker", price: 1299, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 2, description: "Smart Watch", price: 1999, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 1, description: "Wireless Charger", price: 399, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 4, description: "External Hard Drive", price: 1499, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 1, description: "Mechanical Keyboard", price: 1299, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 2, description: "Noise Cancelling Headphones", price: 2499, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 1, description: "Smart Thermostat", price: 1799, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 3, description: "Fitness Tracker", price: 999, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 1, description: "Wireless Earphones", price: 1199, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 2, description: "Gaming Keyboard", price: 899, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 1, description: "Smart Speaker", price: 1499, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 3, description: "Power Bank", price: 599, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 2, description: "Gaming Headset", price: 1299, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 1, description: "Smart Lock", price: 2199, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 4, description: "USB-C Hub", price: 799, product: Product.all.sample, order: Order.all.sample)
OrderItem.create(quantity: 1, description: "Wireless Mouse", price: 499, product: Product.all.sample, order: Order.all.sample)

