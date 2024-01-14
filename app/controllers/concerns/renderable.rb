# frozen_string_literal: true

module Renderable
  extend ActiveSupport::Concern

  EXCEPTION_STATUS = {
    ActiveRecord::RecordNotFound => :not_found,
    ActiveRecord::RecordInvalid => :unprocessable_entity,
    JWT::DecodeError => :unauthorized
  }.freeze

  private

  def render_success(data: nil, status: :ok, serializer: nil, each_serializer: nil)
    render json: {}, status: status if data.nil?

    if serializer
      render json: data, status: status, serializer: serializer
    else
      render json: data, status: status, each_erializer: each_serializer
    end
  end

  def render_errors(exception)
    message = defined?(exception.record) ? exception.record.errors : exception.message
    status = EXCEPTION_STATUS[exception.class] || :internal_server_error

    render json: { errors: message }, status: status
  end
end
