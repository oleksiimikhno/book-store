# frozen_string_literal: true

class SearchValidatorable
  include ActiveModel::Validations

  attr_accessor :query

  def initialize(params)
    params.each_pair do |k,v|
      self.send(:"#{k}=", v) if respond_to?(:"#{k}=")
    end
  end

  validates :query, presence: true, length: { in: 3..30 }
end
