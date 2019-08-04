class ListCurrencies
  extend LightService::Action

  promises :currencies

  executed do |context|
    context.currencies = Money::Currency.all.sort_by(&:iso_code)
  end
end
