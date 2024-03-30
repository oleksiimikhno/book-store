# frozen_string_literal: true

require 'pagy/extras/headers'

module Paginationable
  extend ActiveSupport::Concern
  include Pagy::Backend

  private

  def products_with_pagination(products)
    response.headers['Min-price'] = products.minimum(:price)
    response.headers['Max-price'] = products.maximum(:price)

    pagy, @products = pagy(products, items: limit_params)
    pagy_headers_merge(pagy)
  end

  def limit_params
    params[:limit].to_i.positive? ? params[:limit].to_i : 20
  end
end
