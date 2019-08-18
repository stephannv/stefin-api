FactoryBot.define do
  factory :user do
    name { Faker::Internet.username }
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }

    trait :with_id do
      id { SecureRandom.uuid }
    end
  end
end
