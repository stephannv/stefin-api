FactoryBot.define do
  factory :subcategory do
    category
    name { Faker::Lorem.unique.word }
    icon { Faker::Lorem.word }

    trait :with_id do
      id { SecureRandom.uuid }
    end
  end
end
