# frozen_string_literal: true

module Renderable
  extend ActiveSupport::Concern

  EXCEPTION_STATUS = {
    ActiveRecord::RecordNotFound => :not_found,
    ActiveRecord::RecordInvalid => :unprocessable_entity,
    JWT::DecodeError => :unauthorized,
    Pundit::NotAuthorizedError => :forbidden
  }.freeze

  private

  def render_success(data: nil, status: :ok, serializer: nil, each_serializer: nil)
    render json: {}, status: status if data.nil?

    if serializer
      render json: data, status: status, serializer: serializer
    else
      render json: data, status: status, each_serializer: each_serializer
    end
  end

  def render_errors(exception)
    message = defined?(exception.record) ? exception.record.errors : exception.message
    message = 'Not authorized access' if message.empty?
    status = EXCEPTION_STATUS[exception.class] || :bad_request

    render json: { errors: message }, status: status
  end
end
