# frozen_string_literal: true

module Userable
  extend ActiveSupport::Concern
  include Constable
  include Validateable

  included do
    validate_user_name
    validate_user_name(:last_name)
    validate_email
    validate_password
  end
end
