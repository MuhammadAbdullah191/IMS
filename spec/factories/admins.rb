FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    password { Devise.friendly_token }
    password_confirmation { password }
    username { Faker::Internet.username(specifier: 5..20) }
    phone { '03349949490' }
    role { 'Admin' }

    trait :cashier do
      role { 'Cashier' }
    end

  end
	
end
