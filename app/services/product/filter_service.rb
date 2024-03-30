# frozen_string_literal: true

class Product::FilterService < ApplicationServices
  attr_reader :filter_params

  def initialize(filter_params)
    @params = filter_params
    @products = set_products
  end

  def call
    @products = Product.filter_by_author(@params[:author_name]) if @params[:author_name].present?
    @products = Product.filter_by_range_price(@params[:price_start], @params[:price_end]) if price_start_end_present?
    @products
  end

  private

  def set_products
    @products = Product.all
  end

  def price_start_end_present?
    @params[:price_start].present? && @params[:price_end].present?
  end
end
