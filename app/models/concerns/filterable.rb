# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  included do
    scope :bestsellers, -> { joins(:carts).where(carts: { status: :paid, created_at: 30.days.ago..Date.today.end_of_day }) }
    scope :sales, -> { where('special_price > 0') }

    scope :filter_by_status, ->(status) { where(status: status) }
    scope :filter_by_author, ->(field_value) do
      joins(fields: :label)
        .where("LOWER(fields.value) LIKE LOWER(?)", "%#{field_value}%")
        .where(labels: { title: 'Author' })
    end
    scope :filter_by_range_price, ->(price_start, price_end) { where(price: price_start..price_end) }
    scope :filter_by_attribute, lambda { |key, value|
      joins(labels: :fields).where('LOWER(labels.title) = ?', key).where('LOWER(fields.value) = ?', value)
    }
  end
end
