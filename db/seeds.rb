# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: 'test@test.com', role: 'Admin', password: '111111', password_confirmation: '111111', username: 'test', phone: '03349949490') if Rails.env.development?

Supplier.create(name: 'Supplier 2', email: 'supplier3@gmail.com', phone: '03215472014', address: 'House No 1 Supplier Society Islamabad', created_at: Time.now, updated_at: Time.now)
Supplier.create(name: 'Supplier 5', email: 'supplier5@gmail.com', phone: '03215666666', address: 'House No 4 Supplier Society Karachi', created_at: Time.now, updated_at: Time.now)
Supplier.create(name: 'Supplier 4', email: 'supplier4@gmail.com', phone: '03215555555', address: 'House No 3 Supplier Society Lahore', created_at: Time.now, updated_at: Time.now)

Brand.create(name: 'Brand 1', description:"Brand 1 Description", created_at: Time.now, updated_at: Time.now )
Brand.create(name: 'Brand 3', description:"Brand 3 Description", created_at: Time.now, updated_at: Time.now )
Brand.create(name: 'Brand 2', description:"Brand 2 Description", created_at: Time.now, updated_at: Time.now )

Category.create(title: 'Category 2', description:"Category 2 Description", created_at: Time.now, updated_at: Time.now )
Category.create(title: 'Category 1', description:"Category 1 Description", created_at: Time.now, updated_at: Time.now )
Category.create(title: 'Category 3', description:"Category 3 Description", created_at: Time.now, updated_at: Time.now )

Product.create(name: "Example Product", stock: 10, description: "This is an example product description.", price: 20, location_name: "Example Location", brand_id: 1, category_id: 1, supplier_id: 2, created_at: Time.now, updated_at: Time.now )
Product.create(name: "Product 1", stock: 15, description: "This is a product description.", price: 50, location_name: "Location 1", brand_id: 2, category_id: 2, supplier_id: 4, created_at: Time.now, updated_at: Time.now)
Product.create(name: "Product 2", stock: 20, description: "This is another product description.", price: 80, location_name: "Location 2", brand_id: 3, category_id: 3, supplier_id: 5, created_at: Time.now, updated_at: Time.now)
Product.create(name: "Product 3", stock: 5, description: "This is a third product description.", price: 25, location_name: "Location 3", brand_id: 1, category_id: 1, supplier_id: 3, created_at: Time.now, updated_at: Time.now)
Product.create(name: "Product 4", stock: 30, description: "This is a fourth product description.", price: 60, location_name: "Location 4", brand_id: 2, category_id: 3, supplier_id: 4, created_at: Time.now, updated_at: Time.now)
Product.create(name: "Product 5", stock: 8, description: "This is a fifth product description.", price: 35, location_name: "Location 5", brand_id: 3, category_id: 1, supplier_id: 5, created_at: Time.now, updated_at: Time.now)
Product.create(name: "Product 6", stock: 25, description: "This is a sixth product description.", price: 70, location_name: "Location 6", brand_id: 1, category_id: 2, supplier_id: 3, created_at: Time.now, updated_at: Time.now)
Product.create(name: "Product 7", stock: 12, description: "This is a seventh product description.", price: 45, location_name: "Location 7", brand_id: 2, category_id: 1, supplier_id: 4, created_at: Time.now, updated_at: Time.now)
Product.create(name: "Product 8", stock: 18, description: "This is an eighth product description.", price: 55, location_name: "Location 8", brand_id: 3, category_id: 3, supplier_id: 5, created_at: Time.now, updated_at: Time.now)
Product.create(name: "Product 9", stock: 22, description: "This is a ninth product description.", price: 75, location_name: "Location 9", brand_id: 1, category_id: 2, supplier_id: 3, created_at: Time.now, updated_at: Time.now)
Product.create(name: "Product 10", stock: 3, description: "This is a tenth product description.", price: 30, location_name: "Location 10", brand_id: 2, category_id: 3, supplier_id: 4, created_at: Time.now, updated_at: Time.now)
Product.create(name: "Product 11", stock: 40, description: "This is an eleventh product description.", price: 90, location_name: "Location 11", brand_id: 3, category_id: 1, supplier_id: 5, created_at: Time.now, updated_at: Time.now)