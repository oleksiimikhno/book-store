# frozen_string_literal: true

module Subscriptionable
  extend ActiveSupport::Concern
  include Validateable
  include Constable

  included do
    validate_email
  end
end
