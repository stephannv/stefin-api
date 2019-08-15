module V1
  class RecordEntity < Grape::Entity
    expose :id
    expose :occurred_at
    expose :group
    expose :title
    expose :description
    expose :account, using: 'V1::AccountEntity'
    expose :subcategory, using: 'V1::SubcategoryEntity'
    expose :amount do |record|
      record.amount.to_d.to_s
    end

    expose :amount_currency

    expose :formatted_amount do |record|
      record.amount.formatted
    end
  end
end
