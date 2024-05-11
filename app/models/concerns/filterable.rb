# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  included do
    scope :bestsellers, -> { joins(:carts).where(carts: { status: :paid, created_at: 30.days.ago..Date.today.end_of_day }) }
    scope :sales, -> { where('special_price > 0') }
    scope :availables, -> { where('quantity > 0') }

    scope :filter_by_status, ->(status) { where(status: status) }
    scope :filter_by_author, lambda { |field_value|
      joins(fields: :label)
        .where('LOWER(fields.value) ILIKE LOWER(?)', "%#{sanitize_sql_like(field_value.strip, '%')}%")
        .where(labels: { title: 'Author' })
    }

    scope :filter_by_range_price, lambda { |price_start, price_end|
      where(special_price: price_start..price_end).or(where(price: price_start..price_end))
    }

    scope :filter_by_attribute, lambda { |key, value|
      joins(fields: :label)
        .where('LOWER(fields.value) = LOWER(?)', sanitize_sql_like(value, '%').to_s)
        .where('LOWER(labels.title) = LOWER(?)', sanitize_sql_like(key, '%').to_s)
    }

    # TODO update filter by attributes maybe should use AND or OR operator
    # scope :filter_by_attributes, lambda { |filters|
    #   filters = { 'author' => 'marko', 'format' => 'paper' }

    #   scope = joins(fields: :label)
    #   or_conditions = filters.map do |key, value|
    #     "(LOWER(fields.value) = LOWER(?) AND LOWER(labels.title) = LOWER(?))"
    #   end
    #   scope.where(or_conditions.join(' OR '), *filters.flat_map { |key, value| [sanitize_sql_like(value, '%').to_s, sanitize_sql_like(key, '%').to_s] }.uniq)
    #     .group('products.id')
    #     .having('COUNT(products.id) = ?', filters.size)
    # }
  end
end
