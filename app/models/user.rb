class User < ApplicationRecord
  include Userable

  acts_as_paranoid

  has_secure_password
  
  has_many :carts, dependent: :destroy

  enum :status, %i[visitor admin], default: :visitor
end
