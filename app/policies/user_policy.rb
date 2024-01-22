# frozen_string_literal: true

class UserPolicy < ApplicationPolicy

  def index?
    user_admin?
  end
  def show?
    @record == @user
  end

  alias create? show?
  alias update? show?
  alias destroy? show?
end
