module Stefin
  class BaseAPI < Grape::API
    format :json

    mount Stefin::V1::BaseAPI
  end
end
