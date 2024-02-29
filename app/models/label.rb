# frozen_string_literal: true

class Label < ApplicationRecord
  include Labelable

  has_and_belongs_to_many :products, join_table: :products_labels

  has_many :fields, dependent: :destroy
end
