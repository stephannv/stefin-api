class SaveAccount
  extend LightService::Action

  expects :account

  promises :account

  executed do |context|
    next context if context.account.save

    context.fail!(context.account.errors.full_messages.join(', '))
  end
end
