FactoryBot.define do
  factory :record do
    account
    amount { Monetize.parse(Faker::Number.decimal(l_digits: 3)) }
    occurred_at { Faker::Date.between(from: 1.month.ago, to: Time.zone.today) }
    group { Record.groups.values.sample }
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }

    trait :with_id do
      id { SecureRandom.uuid }
    end

    trait :income do
      group { :income }
    end

    trait :expense do
      group { :expense }
    end

    after(:build) do |record|
      record.amount_currency = record.account.try(:balance_currency)
    end
  end
end
