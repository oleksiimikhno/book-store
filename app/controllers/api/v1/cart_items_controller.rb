class Api::V1::CartItemsController < ApplicationController
  include CartItemableController
  before_action :cart_items_params, :set_cart
  before_action :set_cart_item, :pundit_authorize, except: :create
  before_action :set_product, except: %i[show destroy]

  def show
    render_success(data: @cart_item, each_serializer: Api::V1::CartItemSerializer)
  end

  def create
    result = find_or_create_uniq_record(cart_items_params)

    authorize result

    render_success(data: result, status: 201, each_serializer: Api::V1::CartItemSerializer)
  end

  def update
    @cart_item.update(cart_items_params)

    render_success(data: @cart_item, each_serializer: Api::V1::CartItemSerializer)
  end

  def destroy
    @cart_item.destroy

    render_success(data: { message: 'Cart Items successfully deleted' }, status: :ok)
  end

  private

  def pundit_authorize
    authorize @cart_item
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_cart
    @cart = current_user.carts.find(params[:cart_id])
  end

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_items_params
    params.permit(:quantity, :price, :cart_id, :product_id)
  end
end
