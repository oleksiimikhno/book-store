# frozen_string_literal: true

class Product::FilterService < ApplicationServices
  attr_reader :products, :params

  def initialize(products, params)
    @params = params
    @products = products
  end

  def call
    @products = handler_filter_by_attribute if @params[:filter].present?
    @products = handler_filter_by_status if @params[:status].present?
    @products = @products.filter_by_author(@params[:author_name]) if @params[:author_name].present?
    @products = @products.filter_by_range_price(@params[:price_start], @params[:price_end]) if price_start_end_present?
    @products
  end

  private

  def handler_filter_by_attribute
    queries = @params[:filter].split(';')

    queries.each do |query|
      key, value = query.split('=')
      @products = @products.filter_by_attribute(key.downcase, value.downcase)
    end

    # @products = @products.filter_by_attribute('author', 'marko')
    # @products = @products.filter_by_attribute('format', 'paper')

    @products
  end

  def handler_filter_by_status
    if @params[:status] == 'bestseller'
      @products.bestsellers
    else
      @products.filter_by_status(@params[:status])
    end
  end

  def price_start_end_present?
    @params[:price_start].present? && @params[:price_end].present?
  end
end
