class User < ApplicationRecord
  include Userable

  has_secure_password

  has_many :carts, dependent: :destroy

  enum :status, %i[visitor admin], default: :visitor
end
