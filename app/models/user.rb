class User < ApplicationRecord
  include Userable

  has_secure_password

  has_one :subscription, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :products, through: :favorites

  enum :status, %i[visitor admin], default: :visitor
end
