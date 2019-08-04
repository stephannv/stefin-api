module V1
  class CurrencyEntity < Grape::Entity
    expose :code
    expose :name
  end
end
