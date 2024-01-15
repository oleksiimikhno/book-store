class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items

  enum status: %i[unpaid paid canceled]
end
