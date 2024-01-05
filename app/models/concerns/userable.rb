# frozen_string_literal: true

module Userable
  extend ActiveSupport::Concern
  include Constable

  included do
    def self.validate_name(field = :name)
      validates field, presence: true,
                length: { in: Constable::NAME_LENGTH },
                format: {
                  with: Constable::REGEXP_USER,
                  message: 'Only latin letters allowed, no spaces or special characters'
                }
    end

    def self.validate_email
      validates :email, presence: true,
                length: { in: Constable::EMAIL_LENGTH },
                format: {
                  with: Constable::REGEXP_EMAIL,
                  message: 'Should be in the format: test@test.com'
                }
    end

    def self.validate_password
      validates :password, presence: true,
                format: {
                  with: Constable::REGEXP_PASSWORD,
                  message: 'Must contain at least one uppercase letter, one lowercase letter, and one digit'
                }
    end
  end
end
