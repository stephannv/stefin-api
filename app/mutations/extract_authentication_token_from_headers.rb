class ExtractAuthenticationTokenFromHeaders < Mutations::Command
  required do
    string :authorization_header
  end

  def execute
    authorization_header.to_s.split(' ').last
  end
end
