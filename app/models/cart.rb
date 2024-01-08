class Cart < ApplicationRecord
  belongs_to :user

  enum status: %i[unpaid paid canceled]
end
