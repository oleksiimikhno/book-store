# frozen_string_literal: true

class Api::V1::ProductsController < ApplicationController
  skip_before_action :authorize_request
  before_action :product_params, only: %i[create update]
  before_action :set_product, only: %i[show update destroy]

  def index
    render_success(data: Product.all, status: :ok)
  end

  def show
    render_success(data: @product, status: :ok)
  end

  def create
    product = Product.create!(product_params)

    render_success(data: product, status: :created)
  end

  def update
    @product.update(product_params)

    render_success(data: @product, status: :ok)
  end

  def destroy
    @product.destroy
    render_success(data: { message: 'Product successfully deleted' }, status: :ok)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.permit(:name, :description, :meta_title, :meta_description, :price, :quantity, :status)
  end
end
