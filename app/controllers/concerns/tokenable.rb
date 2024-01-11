# frozen_string_literal: true

require 'jwt'

module Tokenable
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.secret_key_base
  DAYS_TOKEN_EXPIRIES = 24.days.from_now
  DATE_FORMAT = '%m-%d-%Y %H:%M'

  def encode_token(payload)
    payload[:expires] = DAYS_TOKEN_EXPIRIES.strftime(DATE_FORMAT)
    token = JWT.encode(payload, SECRET_KEY)
    { token: token, expires: payload[:expires] }
  end

  def decoded_token(token)
    decode = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decode
  end
end
