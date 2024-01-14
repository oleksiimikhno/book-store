# frozen_string_literal: true

class Product < ApplicationRecord
  include Productable

  belongs_to :category

  enum :status, %i[active inactive archived], default: :active
end
