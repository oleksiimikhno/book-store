# frozen_string_literal: true

class FilterValidatorable
  include ActiveModel::Validations

  attr_accessor :author_name

  def initialize(params)
    params.each_pair do |k,v|
      self.send(:"#{k}=", v) if respond_to?(:"#{k}=")
    end
  end

  validates :author_name, presence: true, length: { maximum: 50 }
end