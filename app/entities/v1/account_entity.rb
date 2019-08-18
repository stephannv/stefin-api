module V1
  class AccountEntity < Grape::Entity
    expose :id
    expose :name
    expose :color
    expose(:balance) { |account| account.balance.to_d.to_s }
    expose :balance_currency
    expose(:formatted_balance) { |account| account.balance.formatted }
  end
end
