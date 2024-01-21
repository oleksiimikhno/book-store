# frozen_string_literal: true

class PasswordPolicy < ApplicationPolicy

  def update?
    @user == @record
  end
end
