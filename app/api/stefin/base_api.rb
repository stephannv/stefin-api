module Stefin
  class BaseAPI < Grape::API
    format :json
    cascade false

    mount Stefin::V1::BaseAPI
  end
end
