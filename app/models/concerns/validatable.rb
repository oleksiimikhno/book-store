module Validateable
  extend ActiveSupport::Concern
  # include Constable

  include do
    def self.validate_name(field = :name, lenght = Constable::NAME_LENGTH)
      validates field, presence: true,
                       length: { in: lenght },
                       format: {
                         with: Constable::REGEXP_USER,
                         message: 'Only latin letters allowed, no spaces or special characters'
                       }
    end

    # def self.validate_description(field = :description)
    #   validates field, length: { in: Constable::DESCRIPTION_LENGTH }
    # end
  end
end
