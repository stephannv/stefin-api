class ListAccounts
  extend LightService::Action

  promises :accounts

  executed do |context|
    context.accounts = Account.all
  end
end
