FactoryBot.define do
  factory :category do
    name { Faker::Lorem.unique.word }
    icon { Faker::Lorem.word }
    color { Faker::Color.hex_color }

    trait :with_id do
      id { SecureRandom.uuid }
    end

    trait :with_subcategories do
      transient do
        subcategories_count { 1 }
      end

      after(:create) do |category, evaluator|
        create_list(:subcategory, evaluator.subcategories_count, category: category)
      end
    end
  end
end
