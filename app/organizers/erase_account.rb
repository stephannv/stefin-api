class EraseAccount
  extend LightService::Organizer

  def self.call(account_id:)
    with(account_id: account_id).reduce(actions)
  end

  def self.actions
    [
      FindAccount,
      DestroyAccount
    ]
  end
end
