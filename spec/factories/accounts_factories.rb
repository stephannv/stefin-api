FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
    balance { Monetize.parse(Faker::Number.decimal(l_digits: 3)) }
    color { Faker::Color.hex_color }
    balance_currency { Money::Currency.to_a.sample.iso_code }

    trait :with_id do
      id { SecureRandom.uuid }
    end
  end
end
