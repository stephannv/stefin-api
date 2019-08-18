class DecodeAuthenticationToken < Mutations::Command
  required do
    string :token
  end

  def execute
    ::Utils::Token.decode(token: token)
  rescue JWT::DecodeError
    nil
  end
end
