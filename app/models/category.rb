class Category < ApplicationRecord
  include Categoryable
  has_many :products
  # has_many :products, -> { where(status: :active) }
end
