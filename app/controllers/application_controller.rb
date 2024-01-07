# frozen_string_literal: true
class ApplicationController < ActionController::API
  private

  def render_success(data: nil, status: :ok)
    if data.nil?
      render json: {}, status: status
    else
      render json: data, status: status
    end
  end

  def render_error(errors: [])
    render json: { errors: errors.record.errors }, status: :unprocessable_entity
  end
end
