# frozen_string_literal: true

module Labelable
  extend ActiveSupport::Concern
  include Constable

  included do
    def self.validate_title(name = :title)
      validates name, presence: true, length: { in: Constable::NAME_LENGTH },
                format: {
                  with: Constable::REGEXP_USER,
                  message: 'Only Latin letters Cyrillic and space are allowed, no special characters'
                }
    end

    validate_title
  end
end
