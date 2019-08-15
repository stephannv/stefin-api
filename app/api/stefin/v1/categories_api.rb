module Stefin
  module V1
    class CategoriesAPI < Grape::API
      helpers do
        def category_params
          declared(params, include_missing: false)[:category].symbolize_keys
        end
      end

      # GET /v1/categories
      desc 'List categories'
      get '/categories' do
        categories = ::ListCategories.run!

        present :categories, categories, with: ::V1::CategoryEntity
      end

      # GET /v1/categories/:id
      desc 'Show category details'
      params do
        requires :id, type: String
      end

      get '/categories/:id' do
        category = ::FindCategory.run!(id: params[:id])

        present :category, category, with: ::V1::CategoryEntity, type: :detailed
      end

      # POST /v1/categories
      desc 'Create a new category'
      params do
        requires :category, type: Hash do
          requires :name, type: String
          requires :color, type: String
          optional :icon, type: String
        end
      end

      post '/categories' do
        category = ::CreateCategory.run!(category_attributes: category_params)

        present :category, category, with: ::V1::CategoryEntity
      end

      # PUT /v1/categories/:id
      desc 'Update a category'
      params do
        requires :id, type: String
        requires :category, type: Hash do
          optional :name, type: String
          optional :color, type: String
          optional :icon, type: String
          at_least_one_of :name, :color, :icon
        end
      end

      patch '/categories/:id' do
        category = ::UpdateCategory.run!(category_id: params[:id], category_attributes: category_params)

        present :category, category, with: ::V1::CategoryEntity
      end

      # DELETE /v1/categories/:id
      desc 'Destroy a category'
      params do
        requires :id, type: String
      end

      delete '/categories/:id' do
        ::EraseCategory.run!(category_id: params[:id])
        status :no_content
      end
    end
  end
end
