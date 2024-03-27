# frozen_string_literal: true

class Product::FilterService < ApplicationServices
  def initialize(filter_params)
    @filter_params = filter_params
  end

  def filter_of_author_name
    Product.filter_by_author(@filter_params)
  end

  private

  attr_reader :filter_params
end
