FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
    balance { 0 }
    color { Faker::Color.hex_color }
    balance_currency { Money::Currency.to_a.sample.iso_code }

    trait :with_id do
      id { SecureRandom.uuid }
    end

    trait :with_records do
      transient do
        records_count { 1 }
      end

      after(:create) do |account, evaluator|
        create_list(:record, evaluator.records_count, account: account)
      end
    end
  end
end
