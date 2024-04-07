# frozen_string_literal: true

class Api::V1::CouponSerializer < ActiveModel::Serializer
  attributes :email, :discount_value, :status, :token
end
