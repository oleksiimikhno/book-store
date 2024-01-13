# frozen_string_literal: true

module Sessionable
  extend ActiveSupport::Concern

  private

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    @decoded = decoded_token(token)
    current_user
  end

  def authenticate?(user, password)
    user&.authenticate(password)
  end
end
