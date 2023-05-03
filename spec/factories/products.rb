FactoryBot.define do
  factory :product do
    name { Faker::Lorem.characters(number: rand(5..20)).capitalize }
    stock { rand(1..100) }
    description { Faker::Lorem.paragraph_by_chars(number: rand(5..50)) }
    price { rand(10..100) }
    categories { build_list(:category, 2) }
    suppliers { build_list(:supplier, 1) }
    brand { build(:brand) }
    after(:build) do |product|
      product.image.attach(
        io: File.open(Rails.root.join('spec', 'support', 'assets','Unknown.jpeg')),
        filename: 'Unknown.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end