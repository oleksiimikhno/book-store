# frozen_string_literal: true

class Product < ApplicationRecord
  include Productable
  include Orderable
  include Filterable

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

  scope :search, ->(query) { where('name || description ILIKE ?', "%#{sanitize_sql_like(query, '%')}%") }
end
