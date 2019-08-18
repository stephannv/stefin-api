module APIAuthenticationMacro
  def mock_authenticate_request
    before do
      Grape::Endpoint.before_each do |endpoint|
        allow(endpoint).to receive(:authenticate_request!).and_return(true)
      end
    end

    after do
      Grape::Endpoint.before_each nil
    end
  end
end
