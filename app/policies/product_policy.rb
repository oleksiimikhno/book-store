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
  alias add_label? create?
  alias remove_label? create?
end
