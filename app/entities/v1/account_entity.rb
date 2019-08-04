module V1
  class AccountEntity < Grape::Entity
    expose :id
    expose :name
    expose :color
    expose :balance do |account|
      account.balance.to_d.to_s
    end

    expose :balance_currency

    expose :formatted_balance do |account|
      account.balance.formatted
    end
  end
end
