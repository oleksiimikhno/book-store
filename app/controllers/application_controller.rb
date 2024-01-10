# frozen_string_literal: true
class ApplicationController < ActionController::API
  include Renderable
  include Tokenable

  before_action :authorize_request
  rescue_from StandardError, with: :render_errors

  private

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    @decoded = decoded_token(token)
    current_user
  end

  def current_user
    User.find(@decoded[:user_id]) if @decoded.present?
  end
end
