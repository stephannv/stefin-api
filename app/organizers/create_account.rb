class CreateAccount
  extend LightService::Organizer

  def self.call(account_attributes:)
    with(account_attributes: account_attributes).reduce(actions)
  end

  def self.actions
    [
      InitializeAccount,
      AssignAccountAttributes,
      SaveAccount
    ]
  end
end
