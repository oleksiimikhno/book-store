# frozen_string_literal: true

class Api::V1::ProductsAwaitingsController < ApplicationController
  include Paginationable
  include Sortable

  skip_before_action :authorize_request
  before_action :set_products, only: :index

  def index
    products_with_pagination(@products)

    render_success(data: @products, status: :ok, each_serializer: Api::V1::ProductSerializer)
  end

  private

  def set_products
    @products = sort_with_params(Product.all.awaiting, params)
  end
end
