class Category < ApplicationRecord
  include Categoryable

  has_many :products
end
