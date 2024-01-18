# frozen_string_literal: true

class Api::V1::ProductsController < ApplicationController
  skip_before_action :authorize_request
  before_action :product_params, only: %i[create update]
  before_action :set_product, only: %i[show update destroy]
  before_action :pundit_authorize, except: %i[index create]

  def index
    products = Product.all

    authorize products

    render_success(data: products, status: :ok, each_serializer: Api::V1::ProductSerializer)
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

  def product_params
    params.permit(:name, :description, :meta_title, :meta_description, :price, :quantity, :status, :category_id)
  end
end
