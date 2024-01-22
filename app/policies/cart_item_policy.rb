# frozen_string_literal: true

class CartItemPolicy < ApplicationPolicy

  def show?
    @user.carts.find(@record.cart_id)
  end

  alias create? show?
  alias update? show?

  def destroy?
    user_admin?
  end
end
