# frozen_string_literal: true

module Userable
  extend ActiveSupport::Concern
  include Validateable
  include Constable

  included do
    def self.validate_user_name(name = :first_name)
      validates name, presence: true, length: { in: Constable::NAME_LENGTH },
                      format: {
                        with: Constable::REGEXP_USER,
                        message: 'Only Latin letters Cyrillic and space are allowed, no special characters'
                      }
    end

    def self.validate_password
      validates :password, presence: true, length: { in: Constable::PASSWORD_LENGTH },
                           format: {
                             with: Constable::REGEXP_PASSWORD,
                             message: 'Must contain at least one uppercase letter, one lowercase letter, and one digit'
                           }
    end

    validate_user_name
    validate_user_name(:last_name)
    validate_email
    validate_password
  end
end
