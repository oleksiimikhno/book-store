# frozen_string_literal: true

class Api::V1::CartsController < ApplicationController
  before_action :cart_params, only: %i[create update]
  before_action :set_cart, only: %i[show update]
  before_action :pundit_authorize, except: %i[index create]

  def index
    carts = current_user.carts

    authorize carts

    render_success(data: carts, each_serializer: Api::V1::CartSerializer)
  end

  def show
    render_success(data: @cart, serializer: Api::V1::CartSerializer)
  end

  def create
    cart = current_user.carts.create!(cart_params)

    authorize cart

    render_success(data: cart, status: :created, serializer: Api::V1::CartSerializer)
  end

  def update
    @cart.update!(cart_params)
    Email::OrderStatusService.call(@cart)

    render_success(data: @cart, status: :ok, serializer: Api::V1::CartSerializer)
  end

  private

  def pundit_authorize
    authorize @cart
  end

  def set_cart
    @cart = current_user.carts.find(params[:id])
  end

  def cart_params
    params.permit(:status)
  end
end
