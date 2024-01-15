# frozen_string_literal: true

module CartItemableModel
  extend ActiveSupport::Concern
  include Validateable
  include Constable

  included do
    validate_field_positive_integer(:quantity)
    validate_field_positive_integer(:price)
    validate_field_presence(:cart_id)
    validate_field_presence(:product_id)
  end
end
