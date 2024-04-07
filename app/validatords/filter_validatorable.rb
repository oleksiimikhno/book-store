# frozen_string_literal: true

class FilterValidatorable
  include ActiveModel::Validations

  attr_accessor :author_name, :price_start, :price_end

  def initialize(params)
    params.each_pair do |k,v|
      self.send(:"#{k}=", v) if respond_to?(:"#{k}=")
    end
  end

  validates :author_name, length: { in: 2..30 }, allow_nil: true
  validates :price_start, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :price_end, numericality: { only_integer: true, greater_than: :price_start }, allow_nil: true
end
