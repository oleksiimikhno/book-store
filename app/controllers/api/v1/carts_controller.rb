# frozen_string_literal: true

class Api::V1::CartsController < ApplicationController
  skip_before_action :authorize_request, only: %i[create destroy]
  before_action :cart_params, only: %i[create update]
  before_action :current_user
  before_action :set_carts, only: :index
  before_action :set_cart, only: %i[show update destroy]

  def index
    render_success(data: @carts, each_serializer: Api::V1::CartSerializer)
  end

  def show
    render_success(data: @cart, serializer: Api::V1::CartSerializer)
  end

  def create
    cart = @user.carts.create!(cart_params)

    render_success(data: cart, status: :created, serializer: Api::V1::CartSerializer)
  end

  def update
    @cart.update!(cart_params)

    render_success(data: @cart, status: :ok, serializer: Api::V1::CartSerializer)
  end

  def destroy
    @cart.destroy!

    render_success(data: { message: 'Cart successfully deleted' }, status: :ok)
  end

  private

  def current_user
    @user = User.find(params[:user_id])
  end

  def set_cart
    @cart = @user.carts.find(params[:id])
  end

  def set_carts
    @carts = @user.carts
  end

  def cart_params
    params.permit(:status)
  end
end
