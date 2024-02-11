class Api::V1::CartItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :quantity, :price, :cart_id, :product_id, :created_at, :updated_at
end
