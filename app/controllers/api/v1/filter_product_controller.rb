# frozen_string_literal: true

class Api::V1::FilterProductController < ApplicationController
  include Pagy::Backend
  include Paginationable

  skip_before_action :authorize_request
  before_action :filter_params, :validates_params, :set_products, only: :index

  def index
    products_with_pagination(@products)
    render_success(data: @products, status: :ok, each_serializer: Api::V1::ProductSerializer)
  end

  private

  def set_products
    @products = Product::FilterService.call(filter_params)
  end

  def validates_params
    instance = FilterValidatorable.new(filter_params)
    return if instance.valid?

    render_success(data: { errors: instance.errors.full_messages }, status: :unprocessable_entity)
  end

  def filter_params
    params.permit(:author_name, :price_start, :price_end)
  end
end
