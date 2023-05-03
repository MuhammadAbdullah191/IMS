
FactoryBot.define do
  factory :order_item do
		description { Faker::Lorem.paragraph_by_chars(number: rand(5..50)) }
    price { Faker::Number.decimal(l_digits: 2) }
    quantity { Faker::Number.within(range: 1..10) }
		product { create(:product) }
		order { create(:order) }
  end
end