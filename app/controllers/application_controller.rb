# frozen_string_literal: true
class ApplicationController < ActionController::API
  rescue_from StandardError, with: :render_errors

  private

  def render_success(data: nil, status: :ok)
    if data.nil?
      render json: {}, status: status
    else
      render json: data, status: status
    end
  end

  def render_errors(exception)
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

  # TODO remove old method
    def render_error(errors: [])
      render json: { errors: errors.record.errors }, status: :unprocessable_entity
    end
end
