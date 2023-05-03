FactoryBot.define do
  factory :order do
		consumer_name { Faker::Lorem.paragraph_by_chars(number: rand(5..50)) }
  end
end