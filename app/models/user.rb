class User < ApplicationRecord
  include Userable

  has_secure_password

  has_many :carts, dependent: :destroy
  has_one :subscription, dependent: :destroy

  enum :status, %i[visitor admin], default: :visitor
end
