module Validateable
  extend ActiveSupport::Concern
  include Constable

  included do
    def self.validate_field(name, lenght = Constable::NAME_LENGTH)
      validates name, presence: true, length: { in: lenght }
    end

    def self.validate_field_can_be_empty(name, lenght = Constable::NAME_LENGTH)
      validates name, presence: true, length: { in: lenght }, allow_blank: true
    end

    def self.validate_field_positive_integer(name, lenght = 0)
      validates name, presence: true, numericality: { greater_than_or_equal_to: lenght }
    end

    def self.validate_image(name, size = Constable::IMAGE_SIZE)
      validates name, content_type: Constable::IMAGE_FORMATS, size: {
        between: size,
        message: 'is not given between size 1KB and 2MB'
      }
    end

    def self.validate_email
      validates :email, presence: true, uniqueness: true, length: { in: Constable::EMAIL_LENGTH },
                        format: {
                          with: Constable::REGEXP_EMAIL,
                          message: 'Should be in the format: test@test.com'
                        }
    end
  end
end
