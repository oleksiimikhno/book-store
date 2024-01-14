# frozen_string_literal: true

module Categoryable
  extend ActiveSupport::Concern
  include Validateable
  include Constable

  included do
    validate_field(:name)
    validate_field(:description, Constable::DESCRIPTION_LENGTH)
  end
end
