require 'rails_helper'

RSpec.describe Stefin::BaseAPI, type: :api do
  describe 'Mounted apps' do
    it 'mounts Stefin::V1::BaseAPI app' do
      is_all_routes_included = Stefin::V1::BaseAPI.routes.all? { |route| described_class.routes.include?(route) }
      expect(is_all_routes_included).to be_truthy
    end
  end
end
