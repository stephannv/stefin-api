class GetUserFromAuthenticationToken < Mutations::Command
  required do
    string :authorization_header
  end

  def execute
    extract_authentication_token_from_headers
    decode_authentication_token
    return if @payload.blank?

    find_user
  rescue ActiveRecord::RecordNotFound
    nil
  end

  private def extract_authentication_token_from_headers
    @token = ExtractAuthenticationTokenFromHeaders.run!(authorization_header: authorization_header)
  end

  private def decode_authentication_token
    @payload = DecodeAuthenticationToken.run!(token: @token)
  end

  private def find_user
    FindUser.run!(id: @payload[:user_id])
  end
end
