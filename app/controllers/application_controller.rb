# frozen_string_literal: true
class ApplicationController < ActionController::API
  include Renderable
  include Tokenable
  include Sessionable

  before_action :authorize_request
  rescue_from StandardError, with: :render_errors

  private

  def current_user
    User.find(@decoded[:user_id]) if @decoded.present?
  end
end
