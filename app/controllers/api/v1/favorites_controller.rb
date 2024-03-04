# frozen_string_literal: true

class Api::V1::FavoritesController < ApplicationController
  before_action :favorite_params, only: %i[create destroy]

  def index
    render_success(data: current_user.products, status: :ok, each_serializer: Api::V1::ProductSerializer)
  end

  def create
    current_user.favorites.create!(favorite_params)

    render_success(data: { message: 'Favorite successfully added' }, status: :created)
  end

  def destroy
    current_user.favorites.destroy!(favorite_params)

    render_success(data: { message: 'Favorite successfully deleted' }, status: :ok)
  end

  private

  def favorite_params
    params.permit(:product_id)
  end
end
