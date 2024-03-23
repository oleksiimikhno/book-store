# frozen_string_literal: true

class Api::V1::ReviewsController < ApplicationController
  skip_before_action :authorize_request, only: :index
  before_action :reviews_params, only: :create
  before_action :set_product, only: %i[index create]

  def index
    render_success(data: @product.reviews, status: :ok, each_serializer: Api::V1::ReviewSerializer)
  end

  def create
    review = @product.reviews.create!(reviews_params.merge(user_id: current_user.id))

    render_success(data: review, status: :created,serializer: Api::V1::ReviewSerializer)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def reviews_params
    params.permit(:text, :rating)
  end
end
