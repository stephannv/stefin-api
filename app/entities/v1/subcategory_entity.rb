module V1
  class SubcategoryEntity < Grape::Entity
    expose :id
    expose :name
    expose :icon
    expose :category do |subcategory, _options|
      V1::CategoryEntity.represent subcategory.category, except: [:subcategories]
    end
  end
end
