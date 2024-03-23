# frozen_string_literal: true

class Product < ApplicationRecord
  include Productable

  belongs_to :category
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :favorites, dependent: :destroy
  has_many :fields, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy

  has_and_belongs_to_many :labels, join_table: :products_labels

  has_one_attached :image, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  enum :status, %i[active inactive awaiting archived], default: :active

  default_scope { order_by_price(:asc) }
  scope :order_by_date, ->(type) { reorder(created_at: type) if type.present? }

  # TODO fix query soring with a price and a special price
  # scope :order_by_price, lambda { |type|
  #   reorder(Arel.sql("(CASE WHEN special_price > 0 THEN special_price ELSE price END) #{type}")) if type.present?
  # }

  scope :order_by_price, ->(type) { reorder(price: type) if type.present? }

  scope :search, ->(query) { where('name || description ILIKE ?', "%#{sanitize_sql_like(query, '%')}%") }
  scope :bestsellers, -> { includes(:carts).where(carts: { status: :paid, created_at: 30.days.ago..Date.today.end_of_day }) }
end
