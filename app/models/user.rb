class User < ApplicationRecord
  include Userable

  has_many :carts, dependent: :destroy
end
