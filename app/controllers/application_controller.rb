# frozen_string_literal: true
class ApplicationController < ActionController::API
  rescue_from StandardError, with: :render_errors
  include Renderable
end
