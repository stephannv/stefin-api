class InitializeAccount
  extend LightService::Action

  promises :account

  executed do |context|
    context.account = Account.new
  end
end
