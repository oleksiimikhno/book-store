class Cart < ApplicationRecord
  belongs_to :user

  enum status: { active: 0, archive: 1 }
end
