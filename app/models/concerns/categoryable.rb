# frozen_string_literal: true

module Categoryable
  extend ActiveSupport::Concern
  include Validateable
  include Constable

  included do
    validate_field(:name)
    validate_field(:description, Constable::DESCRIPTION_LENGTH)
    validate_field_can_be_empty(:meta_title, Constable::META_TITLE_LENGTH)
    validate_field_can_be_empty(:meta_description, Constable::META_DESCRIPTION_LENGTH)
  end
end
