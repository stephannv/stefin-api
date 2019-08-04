class RetrieveCurrencies
  extend LightService::Organizer

  def self.call
    reduce(actions)
  end

  def self.actions
    [
      ListCurrencies
    ]
  end
end
