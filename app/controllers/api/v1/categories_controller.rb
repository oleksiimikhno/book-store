class Api::V1::CategoriesController < ApplicationController
  skip_before_action :authorize_request
  before_action :set_сфеупщкн, only: %i[show update destroy]
  before_action :category_params, only: %i[create update]

  def index
    render_success(data: Category.all, each_serializer: Api::V1::CategorySerializer)
  end

  def show
    render_success(data: @category, serializer: Api::V1::CategorySerializer)
  end

  def create
    category = Category.create!(category_params)

    render_success(data: category, status: :created, serializer: Api::V1::CategorySerializer)
  end

  def update
    @cart.update!(cart_params)

    render_success(data: @category, status: :ok, serializer: Api::V1::CategorySerializer)
  end

  def destroy
    @cart.destroy!

    render_success(data: { message: 'Category successfully deleted' }, status: :ok)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.permit(:name, :description, :meta_name, :meta_description)
  end
end
