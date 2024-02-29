# frozen_string_literal: true

module Fieldable
  extend ActiveSupport::Concern
  include Constable

  included do
    def self.validate_value(name = :value)
      validates name, presence: true, length: { in: Constable::NAME_LENGTH }
    end

    validate_value
  end
end
