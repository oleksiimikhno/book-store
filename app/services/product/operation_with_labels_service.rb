# frozen_string_literal: true

class Product::OperationWithLabelsService < ApplicationServices
  attr_reader :product, :label

  def initialize(product, label)
    @product = product
    @label = label
  end

  def add_label
    if existing_label.nil?
      @product.labels << @label
      { message: 'Label added successfully', status: :ok }
    else
      { message: 'Label with the same id is already assigned to the product', status: :unprocessable_entity }
    end
  end

  def remove_label
    if existing_label.nil?
      { message: 'This product has no such label', status: :unprocessable_entity }
    else
      @product.labels.destroy(@label)
      { message: 'Label removed successfully', status: :ok }
    end
  end

  private

  def existing_label
    @product.labels.find_by(id: @label.id)
  end
end
