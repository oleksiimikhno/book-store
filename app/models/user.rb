class User < ApplicationRecord
  include Userable

  has_secure_password

  has_many :carts
end
