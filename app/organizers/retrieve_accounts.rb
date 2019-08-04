class RetrieveAccounts
  extend LightService::Organizer

  def self.call
    reduce(actions)
  end

  def self.actions
    [
      ListAccounts
    ]
  end
end
