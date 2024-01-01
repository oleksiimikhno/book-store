class User < ApplicationRecord
  include Userable

  has_many :carts

  class_eval do
    validate_name(:first_name)
    validate_name(:last_name)
    validate_email
    validate_password
  end
end
