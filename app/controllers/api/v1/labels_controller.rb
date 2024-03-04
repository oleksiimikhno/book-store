# frozen_string_literal: true

class Api::V1::LabelsController < ApplicationController
  skip_before_action :authorize_request, only: %i[index show]
  before_action :set_label, except: %i[index create]
  before_action :label_params, only: %i[create update]
  before_action :pundit_authorize, only: %i[show update]

  def index
    labels = Label.all

    render_success(data: labels, status: :ok, each_serializer: Api::V1::LabelSerializer)
  end

  def show
    @label

    render_success(data: @label, status: :ok, serializer: Api::V1::LabelSerializer)
  end

  def create
    label = Label.create!(label_params)

    authorize label

    render_success(data: label, status: :created, serializer: Api::V1::LabelSerializer)
  end

  def update
    @label.update!(label_params)

    render_success(data: @label, status: :ok, serializer: Api::V1::LabelSerializer)
  end

  def destroy
    @label.destroy!

    render_success(data: { message: 'Label successfully deleted' }, status: :ok)
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def pundit_authorize
    authorize @label
  end

  def label_params
    params.permit(:title)
  end
end
