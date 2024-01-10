# frozen_string_literal: true

require 'jwt'

module Tokenable
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.secret_key_base
  DAYS_TOKEN_EXPIRIES = 24.days.from_now

  def encode_token(payload, expires = DAYS_TOKEN_EXPIRIES)
    payload[:exp] = expires.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decoded_token(token)
    decode = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decode
  end
end
