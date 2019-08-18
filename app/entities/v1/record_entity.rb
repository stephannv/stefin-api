module V1
  class RecordEntity < Grape::Entity
    expose :id
    expose :occurred_at
    expose :group
    expose :title
    expose :description
    expose :account, using: 'V1::AccountEntity'
    expose :subcategory, using: 'V1::SubcategoryEntity'
    expose(:amount) { |record| record.amount.to_d.to_s }
    expose :amount_currency
    expose(:formatted_amount) { |record| record.amount.formatted }
  end
end
