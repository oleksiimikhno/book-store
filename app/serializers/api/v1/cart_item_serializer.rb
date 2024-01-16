class Api::V1::CartItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price, :cart_id, :product_id, :created_at, :updated_at
end
