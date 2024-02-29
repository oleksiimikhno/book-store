# frozen_string_literal: true

class Field < ApplicationRecord
  include Fieldable

  belongs_to :label
  belongs_to :product
end
