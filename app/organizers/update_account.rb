class UpdateAccount
  extend LightService::Organizer

  def self.call(account_id:, account_attributes:)
    with(account_id: account_id, account_attributes: account_attributes).reduce(actions)
  end

  def self.actions
    [
      FindAccount,
      AssignAccountAttributes,
      SaveAccount
    ]
  end
end
