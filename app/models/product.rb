# frozen_string_literal: true

class Product < ApplicationRecord
  include Productable

  enum :status, %i[active inactive archived], default: :active
end
