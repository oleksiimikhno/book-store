# frozen_string_literal: true

class CartPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    record.any? { |cart| cart.user == user }
  end

  def show?
    record.user == user
  end

  alias update? show?

  def create?
    true
  end

  def destroy?
    false
  end
end
