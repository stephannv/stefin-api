class GenerateUserAuthenticationToken < Mutations::Command
  required do
    model :user
  end

  def execute
    Utils::Token.encode(payload: { user_id: user.id }, expiration_time_in_minutes: 60 * 24 * 7)
  end
end
