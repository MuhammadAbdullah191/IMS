FactoryBot.define do
  factory :supplier do
    name { Faker::Lorem.characters(number: rand(5..20)).capitalize }
		email { Faker::Internet.email }
		phone { '03349949490' }
    address { Faker::Lorem.characters(number: rand(5..200)).capitalize }
    after(:build) do |supplier|
      supplier.image.attach(
        io: File.open(Rails.root.join('spec', 'support', 'assets','Unknown.jpeg')),
        filename: 'Unknown.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end