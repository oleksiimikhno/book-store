# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user_admin?
  end
  def show?
    record == user
  end

  alias create? show?
  alias update? show?
  alias destroy? index?
end
