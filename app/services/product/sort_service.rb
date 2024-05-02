# frozen_string_literal: true

class Product::SortService < ApplicationServices
  attr_reader :products, :params

  def initialize(products, params)
    @params = params
    @products = products
  end

  def call
    @products = @products.order_by_date(params[:order]) if params[:order].present?
    @products = @products.order_by_price(params[:price]) if params[:price].present?
    @products = @products.order_by_rating(params[:rating]) if params[:rating].present?
    @products
  end

  private

  def price_start_end_present?
    @params[:price_start].present? && @params[:price_end].present?
  end
end
