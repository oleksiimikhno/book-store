# frozen_string_literal: true

class Api::V1::FieldsController < ApplicationController
  skip_before_action :authorize_request, only: %i[index show]
  before_action :set_label
  before_action :set_field, except: %i[index create]
  before_action :field_params, only: %i[create update]
  before_action :pundit_authorize, only: %i[show update destroy]

  def index
    fields = @label.fields.where(product_id: params[:product_id])

    authorize fields

    render_success(data: fields, status: :ok, each_serializer: Api::V1::FieldSerializer)
  end

  def show
    @field

    render_success(data: @field, status: :ok, serializer: Api::V1::FieldSerializer)
  end

  def create
    field = @label.fields.new(field_params)

    field.product_id = params[:product_id]

    authorize field

    field.save!

    render_success(data: field, status: :created, serializer: Api::V1::FieldSerializer)
  end

  def update
    @field.update!(field_params)

    render_success(data: @field, status: :ok, serializer: Api::V1::FieldSerializer)
  end

  def destroy
    @field.destroy!

    render_success(data: { message: 'Field successfully deleted' }, status: :ok)
  end

  private

  def set_label
    @label = Label.find(params[:label_id])
  end

  def set_field
    @field = @label.fields.find_by(product_id: params[:product_id])
  end

  def pundit_authorize
    authorize @field
  end

  def field_params
    params.permit(:value)
  end
end
