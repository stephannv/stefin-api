module V1
  class CurrencyEntity < Grape::Entity
    expose :iso_code, as: :code
    expose :code, as: :symbol
    expose :name
  end
end
