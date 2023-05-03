FactoryBot.define do
  factory :category do
    name { Faker::Lorem.characters(number: rand(5..20)).capitalize }
    description { Faker::Lorem.sentence(word_count: 10) }
  end
  
end