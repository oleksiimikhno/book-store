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

    def self.validate_user_name(name = :first_name)
      validates name, presence: true,
                length: { in: Constable::NAME_LENGTH },
                format: {
                  with: Constable::REGEXP_USER,
                  message: 'Only latin letters allowed, no spaces or special characters'
                }
    end

    def self.validate_email
      validates :email, presence: true, uniqueness: true,
                length: { in: Constable::EMAIL_LENGTH },
                format: {
                  with: Constable::REGEXP_EMAIL,
                  message: 'Should be in the format: test@test.com'
                }
    end

    def self.validate_password
      validates :password, presence: true,
                length: { in: Constable::PASSWORD_LENGTH },
                format: {
                  with: Constable::REGEXP_PASSWORD,
                  message: 'Must contain at least one uppercase letter, one lowercase letter, and one digit'
                }
    end
  end
end
