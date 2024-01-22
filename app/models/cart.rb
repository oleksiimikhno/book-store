class Cart < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items

  enum status: %i[unpaid paid canceled]
end
