# frozen_string_literal: true

module Reviewable
  extend ActiveSupport::Concern
  include Validateable
  include Constable

  included do
    validate_field(:text, Constable::DESCRIPTION_LENGTH)

    def self.validate_rating
      validates :rating, presence: true, inclusion: { in: 1..5 }
    end
  end
end
