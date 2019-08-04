class DestroyAccount
  extend LightService::Action

  expects :account

  executed do |context|
    next context if context.account.destroy

    context.fail_and_return!(context.account.errors.full_messages.join(', '))
  end
end
