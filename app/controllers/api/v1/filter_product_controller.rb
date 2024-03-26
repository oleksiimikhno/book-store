# frozen_string_literal: true

class Api::V1::FilterProductController < ApplicationController
  include Pagy::Backend
  include Paginationable

  skip_before_action :authorize_request
  before_action :filter_params, :set_products, :validates_params, only: :index

  def index
    products_with_pagination(@products)

    render_success(data: @products, status: :ok, each_serializer: Api::V1::ProductSerializer)
  end

  private

  def set_products
    @products = Product::FilterService.new(filter_params[:author_name]).filter_of_author_name
  end

  def validates_params
    return if FilterValidatorable.new(filter_params).valid?

    render_success(data: { errors: 'Search author_name param too long or wrong key!' }, status: :unprocessable_entity)
  end


  def filter_params
    params.permit(:author_name)
  end
end
