# frozen_string_literal: true

class Api::V1::ProductsBestsellersController < ApplicationController
  include Paginationable

  skip_before_action :authorize_request
  before_action :set_products, only: :index

  def index
    @products = Product::FilterService.call(@products, params)
    @products = Product::SortService.call(@products, params)
    products_with_pagination(@products)

    render_success(data: @products, status: :ok, each_serializer: Api::V1::ProductSerializer)
  end

  private

  def set_products
    @products = Product.bestsellers
  end
end
