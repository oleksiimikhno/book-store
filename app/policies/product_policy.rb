# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    user_admin?
  end

  alias show? index?
  alias update? create?
  alias destroy? create?
end
