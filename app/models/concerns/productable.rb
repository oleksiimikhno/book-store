# frozen_string_literal: true

module Productable
  extend ActiveSupport::Concern
  # include Constable::Validateable

      def self.validate_name(field = :name, lenght = Constable::NAME_LENGTH)
      validates field, presence: true,
                       length: { in: lenght },
                       format: {
                         with: Constable::REGEXP_USER,
                         message: 'Only latin letters allowed, no spaces or special characters'
                       }
    end

  included do
    validate_name
    # def self.validate_name(field = :name, lenght = Constable::NAME_LENGTH)
    #   debugger
    #   validates field, presence: true,
    #                    length: { in: lenght },
    #                    format: {
    #                      with: Constable::REGEXP_USER,
    #                      message: 'Only latin letters allowed, no spaces or special characters'
    #                    }
    # end
  end
end
