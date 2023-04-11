# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin.create!(email: 'test@test.com', role: 'Admin', password: '111111', password_confirmation: '111111', username: 'test', phone: '03349949490') if Rails.env.development?

# Supplier.create(name: 'Supplier 2', email: 'supplier3@gmail.com', phone: '03215472014', address: 'House No 1 Supplier Society Islamabad', created_at: Time.now, updated_at: Time.now)
# Supplier.create(name: 'Supplier 5', email: 'supplier5@gmail.com', phone: '03215666666', address: 'House No 4 Supplier Society Karachi', created_at: Time.now, updated_at: Time.now)
# Supplier.create(name: 'Supplier 4', email: 'supplier4@gmail.com', phone: '03215555555', address: 'House No 3 Supplier Society Lahore', created_at: Time.now, updated_at: Time.now)

# Brand.create(name: 'Brand 1', description:"Brand 1 Description", created_at: Time.now, updated_at: Time.now )
# Brand.create(name: 'Brand 3', description:"Brand 3 Description", created_at: Time.now, updated_at: Time.now )
# Brand.create(name: 'Brand 2', description:"Brand 2 Description", created_at: Time.now, updated_at: Time.now )

# Category.create(title: 'Category 2', description:"Category 2 Description", created_at: Time.now, updated_at: Time.now )
# Category.create(title: 'Category 1', description:"Category 1 Description", created_at: Time.now, updated_at: Time.now )
# Category.create(title: 'Category 3', description:"Category 3 Description", created_at: Time.now, updated_at: Time.now )

# Product.create(name: "Example Product", stock: 10, description: "This is an example product description.", price: 20, location_name: "Example Location", brand_id: 1, category_id: 1, supplier_id: 2, created_at: Time.now, updated_at: Time.now )
# Product.create(name: "Product 1", stock: 15, description: "This is a product description.", price: 50, location_name: "Location 1", brand_id: 2, category_id: 2, supplier_id: 4, created_at: Time.now, updated_at: Time.now)
# Product.create(name: "Product 2", stock: 20, description: "This is another product description.", price: 80, location_name: "Location 2", brand_id: 3, category_id: 3, supplier_id: 5, created_at: Time.now, updated_at: Time.now)
# Product.create(name: "Product 3", stock: 5, description: "This is a third product description.", price: 25, location_name: "Location 3", brand_id: 1, category_id: 1, supplier_id: 3, created_at: Time.now, updated_at: Time.now)
# Product.create(name: "Product 4", stock: 30, description: "This is a fourth product description.", price: 60, location_name: "Location 4", brand_id: 2, category_id: 3, supplier_id: 4, created_at: Time.now, updated_at: Time.now)
# Product.create(name: "Product 5", stock: 8, description: "This is a fifth product description.", price: 35, location_name: "Location 5", brand_id: 3, category_id: 1, supplier_id: 5, created_at: Time.now, updated_at: Time.now)
# Product.create(name: "Product 6", stock: 25, description: "This is a sixth product description.", price: 70, location_name: "Location 6", brand_id: 1, category_id: 2, supplier_id: 3, created_at: Time.now, updated_at: Time.now)
# Product.create(name: "Product 7", stock: 12, description: "This is a seventh product description.", price: 45, location_name: "Location 7", brand_id: 2, category_id: 1, supplier_id: 4, created_at: Time.now, updated_at: Time.now)
# Product.create(name: "Product 8", stock: 18, description: "This is an eighth product description.", price: 55, location_name: "Location 8", brand_id: 3, category_id: 3, supplier_id: 5, created_at: Time.now, updated_at: Time.now)
# Product.create(name: "Product 9", stock: 22, description: "This is a ninth product description.", price: 75, location_name: "Location 9", brand_id: 1, category_id: 2, supplier_id: 3, created_at: Time.now, updated_at: Time.now)
# Product.create(name: "Product 10", stock: 3, description: "This is a tenth product description.", price: 30, location_name: "Location 10", brand_id: 2, category_id: 3, supplier_id: 4, created_at: Time.now, updated_at: Time.now)
# Product.create(name: "Product 11", stock: 40, description: "This is an eleventh product description.", price: 90, location_name: "Location 11", brand_id: 3, category_id: 1, supplier_id: 5, created_at: Time.now, updated_at: Time.now)

# Seed Suppliers
# Supplier.create(name: "ABC Corporation", email: "abc@example.com", phone: "+923001234567", address: "123 Main Street, Karachi, Pakistan", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Supplier.create(name: "DEF Inc", email: "def@example.com", phone: "+923041234567", address: "456 Second Street, Lahore, Pakistan", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Supplier.create(name: "GHI Enterprises", email: "ghi@example.com", phone: "+923081234567", address: "789 Third Street, Islamabad, Pakistan", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Supplier.create(name: "JKL Industries", email: "jkl@example.com", phone: "+923121234567", address: "101 Fourth Street, Rawalpindi, Pakistan", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Supplier.create(name: "MNO Trading", email: "mno@example.com", phone: "+923161234567", address: "202 Fifth Street, Peshawar, Pakistan", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# # # Seed Brands
# Brand.create(name: "Nike", description: "Sportswear and accessories brand", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Brand.create(name: "Adidas", description: "Sportswear and accessories brand", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Brand.create(name: "Apple", description: "Technology and electronics brand", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Brand.create(name: "Samsung", description: "Technology and electronics brand", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Brand.create(name: "Toyota", description: "Automobile brand", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# # Seed Categories
# Category.create(title: "Men's Clothing", description: "Clothing for men", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Category.create(title: "Women's Clothing", description: "Clothing for women", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Category.create(title: "Electronics", description: "Electronic devices and accessories", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Category.create(title: "Sports Equipment", description: "Equipment for sports and fitness", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Category.create(title: "Home Appliances", description: "Appliances for home use", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# brands = Brand.all
# categories = Category.all
# suppliers = Supplier.all

# Product.create(name: "Apple iPhone 13", stock: 50, description: "New iPhone with A15 chip", price: 799.99, location_name: "Warehouse A", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Sony PS5", stock: 50, description: "Next-gen gaming console", price: 499.99, location_name: "Warehouse A", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Dell XPS 13", stock: 50, description: "Thin and light laptop", price: 1199.99, location_name: "Warehouse A", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Bose QuietComfort ", stock: 50, description: "Noise-cancelling earbuds", price: 279.99, location_name: "Warehouse A", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Nike Air Max 2090", stock: 50, description: "New futuristic sneaker", price: 149.99, location_name: "Warehouse A", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Samsung QLED TV", stock: 50, description: "Crystal clear picture", price: 1999.99, location_name: "Warehouse A", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Fitbit Charge 5", stock: 50, description: "Advanced fitness tracker", price: 179.99, location_name: "Warehouse A", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "GoPro Hero 10", stock: 50, description: "High-quality action camera", price: 449.99, location_name: "Warehouse A", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Microsoft Laptop", stock: 50, description: "Versatile 2-in-1 device", price: 899.99, location_name: "Warehouse A", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Apple AirPods Pro", stock: 100, description: "Noise-cancelling earbuds", price: 249.99, location_name: "Warehouse B", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Fitbit Charge 5", stock: 75, description: "Fitness tracker with GPS", price: 179.99, location_name: "Warehouse C", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Sony WH-1000XM4", stock: 30, description: "Wireless noise-cancelling headphones", price: 349.99, location_name: "Warehouse A", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Nintendo  OLED", stock: 20, description: "New OLED version of the popular console", price: 349.99, location_name: "Warehouse B", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Product.create(name: "Bose QuietComfort Earbuds", stock: 50, description: "True wireless noise-cancelling earbuds", price: 279.99, location_name: "Warehouse C", brand: brands.sample, category: categories.sample, supplier: suppliers.sample, created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# Order.create(consumer_name: "John Smith", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Order.create(consumer_name: "Emily Brown", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Order.create(consumer_name: "William Davis", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Order.create(consumer_name: "Jessica Garcia", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Order.create(consumer_name: "Daniel Martin", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Order.create(consumer_name: "Mia Johnson", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)
# Order.create(consumer_name: "Ethan Lee", created_at: (rand(6.days.ago..Time.now)).to_datetime, updated_at: Time.now)

# # OrderItem 1
# OrderItem.create(quantity: 2, description: "Wireless Earbuds", price: 899, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 2
# OrderItem.create(quantity: 1, description: "Gaming Mouse", price: 699, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 3
# OrderItem.create(quantity: 3, description: "Bluetooth Speaker", price: 1299, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 4
# OrderItem.create(quantity: 2, description: "Smart Watch", price: 1999, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 5
# OrderItem.create(quantity: 1, description: "Wireless Charger", price: 399, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 6
# OrderItem.create(quantity: 4, description: "External Hard Drive", price: 1499, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 7
# OrderItem.create(quantity: 1, description: "Mechanical Keyboard", price: 1299, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 8
# OrderItem.create(quantity: 2, description: "Noise Cancelling Headphones", price: 2499, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 9
# OrderItem.create(quantity: 1, description: "Smart Thermostat", price: 1799, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 10
# OrderItem.create(quantity: 3, description: "Fitness Tracker", price: 999, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 11
# OrderItem.create(quantity: 1, description: "Wireless Earphones", price: 1199, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 12
# OrderItem.create(quantity: 2, description: "Gaming Keyboard", price: 899, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 13
# OrderItem.create(quantity: 1, description: "Smart Speaker", price: 1499, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 14
# OrderItem.create(quantity: 3, description: "Power Bank", price: 599, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 15
# OrderItem.create(quantity: 2, description: "Gaming Headset", price: 1299, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 16
# OrderItem.create(quantity: 1, description: "Smart Lock", price: 2199, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 17
# OrderItem.create(quantity: 4, description: "USB-C Hub", price: 799, product: Product.all.sample, order: Order.all.sample)

# # OrderItem 18
# OrderItem.create(quantity: 1, description: "Wireless Mouse", price: 499, product: Product.all.sample, order: Order.all.sample)

# categories = Category.all

# Product.find_each do |product|
#   product.categories << categories.sample(rand(1..3))
# end

supplier = Supplier.all

Product.find_each do |product|
  product.suppliers << supplier.sample(rand(1..3))
end
