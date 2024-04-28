# frozen_string_literal: true

class Api::V1::ProductsController < ApplicationController
  include Paginationable

  skip_before_action :authorize_request, only: %i[index show]
  before_action :product_params, only: %i[create update]
  before_action :set_category, if: -> { params[:category_id] }
  before_action :set_product, only: %i[show update destroy add_label remove_label]
  before_action :set_label, only: %i[add_label remove_label]
  before_action :set_products, only: %i[index]
  before_action :pundit_authorize, except: %i[index create]

  def index
    @products = Product::FilterService.call(@products, params)
    @products = Product::SortService.call(@products, params)
    products_with_pagination(@products)

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

  def add_label
    label_service = Product::OperationWithLabelsService.new(@product, @label)
    result = label_service.add_label

    render_success(data: { message: result[:message] }, status: result[:status])
  end

  def remove_label
    label_service = Product::OperationWithLabelsService.new(@product, @label)
    result = label_service.remove_label

    render_success(data: { message: result[:message] }, status: result[:status])
  end

  private

  def pundit_authorize
    authorize @product
  end

  def set_label
    @label = Label.find(params[:label_id])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_products
    @products = params[:category_id] ? @category.products : Product.all
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def product_params
    params.permit(:name, :description, :meta_title, :meta_description, :price, :special_price, :model, :quantity,
                  :status, :category_id, :image, images: [])
  end
end
