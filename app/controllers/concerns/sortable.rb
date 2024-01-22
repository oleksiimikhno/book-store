# frozen_string_literal: true

module Sortable 
  extend ActiveSupport::Concern

  private

  def sort_with_params(items, params)
    items = items.order_by_date(params[:order]) if params[:order].present?
    items = items.order_by_price(params[:price]) if params[:price].present?
    items
  end
end
