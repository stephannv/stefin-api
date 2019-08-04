class FindAccount
  extend LightService::Action

  expects :account_id

  promises :account

  executed do |context|
    context.account = Account.find(context.account_id)
  end
end
