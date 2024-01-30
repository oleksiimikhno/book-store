# frozen_string_literal: true

class SearchValidatorable
  include ActiveModel::Validations

  def initialize(params)
    params.each_pair{|k,v|
      self.send(:"#{k}=", v) if respond_to?(:"#{k}=")
    }
  end

  attr_accessor :query

  validates :query, presence: true, length: { in: 3..30 }
end
