# frozen_string_literal: true

module Productable
  extend ActiveSupport::Concern
  include Validateable
  include Constable

  included do
    validate_field(:name)
    validate_field(:description, Constable::DESCRIPTION_LENGTH)
    validate_field_can_be_empty(:meta_title, Constable::META_TITLE_LENGTH)
    validate_field_can_be_empty(:meta_description, Constable::META_DESCRIPTION_LENGTH)
    validate_field_positive_integer(:quantity)
    validate_field_positive_integer(:price)
    validate_field_positive_integer(:discount)
    validate_field(:model, Constable::MODEL_LENGTH)
    validate_field_positive_integer(:category_id)
    validate_image(:image)
    validate_image(:images)
  end
end
