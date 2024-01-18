# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user, :record
  def show?
    record == user
  end

  def destroy?
    false
  end

  alias create? show?
  alias update? show?
end
