# frozen_string_literal: true

require 'pagy/extras/headers'

class Api::V1::ProductsController < ApplicationController
  include Pagy::Backend
  include Paginationable
  include Sortable

  skip_before_action :authorize_request, only: %i[index show]
  before_action :product_params, only: %i[create update]
  before_action :set_category, if: -> { params[:category_id] }
  before_action :set_product, only: %i[show update destroy]
  before_action :set_products, :limit_params, only: %i[index]
  before_action :pundit_authorize, except: %i[index create]

  def index
    pagy, @products = pagy(@products, items: limit_params)
    pagy_headers_merge(pagy)

    render_success(data: @products, status: :ok, each_serializer: Api::V1::ProductSerializer)
  end

  def show
    render_success(data: @product, status: :ok, serializer: Api::V1::ProductSerializer)
  end

  def create
    product = Product.create!(product_params)

    authorize product

    render_success(data: product, status: :created, serializer: Api::V1::ProductSerializer)
  end

  def update
    @product.update(product_params)

    render_success(data: @product, status: :ok, serializer: Api::V1::ProductSerializer)
  end

  def destroy
    @product.destroy

    render_success(data: { message: 'Product successfully deleted' }, status: :ok)
  end

  private

  def pundit_authorize
    authorize @product
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_products
    @products = if params[:category_id].present?
                  @products = sort_with_params(@category.products, params)
                else
                  Product.all
                end
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def product_params
    params.permit(:name, :description, :meta_title, :meta_description, :price, :quantity, :status, :category_id,
                  :image, images: [])
  end
end
