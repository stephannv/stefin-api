module Stefin
  module V1
    class SubcategoriesAPI < Grape::API
      helpers do
        def subcategory_params
          declared(params, include_missing: false)[:subcategory].symbolize_keys
        end
      end

      # GET /v1/subcategories
      desc 'List subcategories'
      get '/subcategories' do
        subcategories = ::ListSubcategories.run!

        present :subcategories, subcategories, with: ::V1::SubcategoryEntity
      end

      # GET /v1/subcategories/:id
      desc 'Show subcategory details'
      params do
        requires :id, type: String
      end

      get '/subcategories/:id' do
        subcategory = ::FindSubcategory.run!(id: params[:id])

        present :subcategory, subcategory, with: ::V1::SubcategoryEntity
      end

      # POST /v1/subcategories
      desc 'Create a new subcategory'
      params do
        requires :subcategory, type: Hash do
          requires :category_id, type: String
          requires :name, type: String
          optional :icon, type: String
        end
      end

      post '/subcategories' do
        subcategory = ::CreateSubcategory.run!(subcategory_attributes: subcategory_params)

        present :subcategory, subcategory, with: ::V1::SubcategoryEntity
      end

      # PUT /v1/subcategories/:id
      desc 'Update a subcategory'
      params do
        requires :id, type: String
        requires :subcategory, type: Hash do
          optional :category_id, type: String
          optional :name, type: String
          optional :icon, type: String
          at_least_one_of :name, :color, :icon
        end
      end

      patch '/subcategories/:id' do
        subcategory = ::UpdateSubcategory.run!(subcategory_id: params[:id], subcategory_attributes: subcategory_params)

        present :subcategory, subcategory, with: ::V1::SubcategoryEntity
      end

      # DELETE /v1/subcategories/:id
      desc 'Destroy a subcategory'
      params do
        requires :id, type: String
      end

      delete '/subcategories/:id' do
        ::EraseSubcategory.run!(subcategory_id: params[:id])
        status :no_content
      end
    end
  end
end
