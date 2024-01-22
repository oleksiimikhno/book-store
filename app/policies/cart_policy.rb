# frozen_string_literal: true

class CartPolicy < ApplicationPolicy

  def index?
    @record.any? { |cart| cart.user == @user }
  end

  def show?
    @record.user == @user
  end

  def create?
    true
  end

  def destroy?
    user_admin?
  end

  alias update? show?
end
