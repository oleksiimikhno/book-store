# frozen_string_literal: true

module Orderable
  extend ActiveSupport::Concern

  included do
    default_scope { order_by_price(:asc) }

    scope :order_by_date, ->(type) { reorder(created_at: type) }
    scope :order_by_price, ->(type) { reorder(price: type) }
    scope :order_by_rating, ->(type) { left_joins(:reviews).group(:id).reorder("AVG(reviews.rating) #{type}") }

    # TODO fix query soring with a price and a special price
    # scope :order_by_price, lambda { |type|
    #   reorder(Arel.sql("(CASE WHEN special_price > 0 THEN special_price ELSE price END) #{type}")) if type.present?
    # }
  end
end
