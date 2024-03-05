# frozen_string_literal: true

class Api::V1::FavoritesController < ApplicationController
  before_action :favorite_params, only: %i[create destroy]
  before_action :set_favorite, only: :destroy

  def index
    render_success(data: current_user.products, status: :ok, each_serializer: Api::V1::ProductSerializer)
  end

  def create
    current_user.favorites.create!(product_id: params[:product_id])

    render_success(data: { message: 'Favorite successfully added' }, status: :created)
  end

  def destroy
    @favorite.destroy!

    render_success(data: { message: 'Favorite successfully deleted' }, status: :ok)
  end

  private

  def set_favorite
    @favorite = current_user.favorites.find_by(product_id: params[:product_id])
  end

  def favorite_params
    params.permit(:product_id)
  end
end
