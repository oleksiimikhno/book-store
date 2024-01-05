# frozen_string_literal: true

class Api::V1::ProductsController < ApplicationController
  before_action :product_params, only: %i[create update]
  before_action :set_product, only: %i[show update destroy]

  def show
    render json: @product, status: :ok
  end

  def create
    Product.create(product_params)
  end

  def update
    @product.update(product_params)

    render json: @product, status: :ok
  end

  def destroy
    @product.destroy
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :meta_title, :meta_description, :price, :quantity, :status)
  end
end
