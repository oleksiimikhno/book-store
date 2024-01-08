# frozen_string_literal: true
class ApplicationController < ActionController::API
  rescue_from StandardError, with: :render_error

  private

  def render_success(data: nil, status: :ok)
    if data.nil?
      render json: {}, status: status
    else
      render json: data, status: status
    end
  end

  def render_error(exception)
    status = case exception
             when ActiveRecord::RecordNotFound
               :not_found
             when ActiveRecord::RecordInvalid
               :unprocessable_entity
             else
               :internal_server_error
             end

    render json: { error: exception.message }, status: status
  end
end
