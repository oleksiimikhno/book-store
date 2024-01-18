# frozen_string_literal: true

class CartItemPolicy < ApplicationPolicy
  attr_reader :user, :record
  def show?
    Cart.find(record.cart_id).user == user
  end

  alias create? show?
  alias update? show?
  alias destroy? show?
end
