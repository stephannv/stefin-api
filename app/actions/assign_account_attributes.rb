class AssignAccountAttributes
  extend LightService::Action

  expects :account
  expects :account_attributes

  promises :account

  executed do |context|
    context.account.assign_attributes(context.account_attributes)
  end
end
