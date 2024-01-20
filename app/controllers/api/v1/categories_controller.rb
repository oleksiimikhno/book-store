class Api::V1::CategoriesController < ApplicationController
  skip_before_action :authorize_request
  before_action :set_category, only: %i[show update destroy]
  before_action :category_params, only: %i[create update]
  before_action :pundit_authorize, except: %i[index create]

  def index
    categories = Category.all

    authorize categories

    render_success(data: categories, each_serializer: Api::V1::CategorySerializer)
  end

  def show
    render_success(data: @category, serializer: Api::V1::CategorySerializer)
  end

  def create
    category = Category.create!(category_params)

    authorize category

    render_success(data: category, status: :created, serializer: Api::V1::CategorySerializer)
  end

  def update
    @category.update!(category_params)

    render_success(data: @category, status: :ok, serializer: Api::V1::CategorySerializer)
  end

  def destroy
    @category.destroy!

    render_success(data: { message: 'Category successfully deleted' }, status: :ok)
  end

  private

  def pundit_authorize
    authorize @category
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.permit(:name, :description, :meta_name, :meta_description)
  end
end
