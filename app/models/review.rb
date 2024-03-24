# frozen_string_literal: true

class Review < ApplicationRecord
  include Reviewable

  belongs_to :reviewable, polymorphic: true
  belongs_to :user
end
