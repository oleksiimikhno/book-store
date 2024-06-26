# frozen_string_literal: true

require 'pagy/extras/headers'

class Api::V1::SearchController < ApplicationController
  include Pagy::Backend
  include Paginationable

  skip_before_action :authorize_request
  before_action :search_params, :validates_params, :set_products, only: :index

  def index
    @products = Product::FilterService.call(@products, params)
    @products = Product::SortService.call(@products, params)
    products_with_pagination(@products)

    render_success(data: @products, status: :ok, each_serializer: Api::V1::ProductSerializer)
  end

  private

  def set_products
    @products = Product.all.search(params[:query])
  end

  def validates_params
    instance = SearchValidatorable.new(search_params)
    return if instance.valid?

    render_success(data: { errors: instance.errors.full_messages }, status: :unprocessable_entity)
  end

  def search_params
    params.permit(:query)
  end
end
