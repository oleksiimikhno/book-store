class Api::V1::CartItemsController < ApplicationController
  include CartItemableController
  before_action :cart_items_params, :set_cart, :set_product, :set_cart_item, except: :show

  def show
    cart_item = CartItem.find(params[:id])

    render_success(data: cart_item)
  end

  def create
    result = find_or_create_uniq_record(@cart_item, cart_items_params)

    render_success(data: result, status: 201)
  end

  def update
    @cart_item.update(cart_items_params)

    render_success(data:@cart_item)
  end

  def destroy
    @cart_item.destroy

    render_success(data: { message: 'Cart Items successfully deleted' }, status: :ok)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_cart
    @cart = current_user.carts.find(params[:cart_id])
  end

  def set_cart_item
    @cart_item = CartItem.find_by(cart_id: @cart.id, product_id: @product.id)
  end

  def cart_items_params
    params.permit(:quantity, :price, :cart_id, :product_id)
  end
end
