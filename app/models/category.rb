class Category < ApplicationRecord
  include Categoryable

  acts_as_paranoid

  has_many :products, -> { where(status: :active) }
end
