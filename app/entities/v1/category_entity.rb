module V1
  class CategoryEntity < Grape::Entity
    expose :id
    expose :name
    expose :color
    expose :icon
    expose :subcategories, if: { type: :detailed } do |category|
      V1::SubcategoryEntity.represent category.subcategories, except: [:category]
    end
  end
end
