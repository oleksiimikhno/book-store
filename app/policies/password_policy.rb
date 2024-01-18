# frozen_string_literal: true

class PasswordPolicy < ApplicationPolicy
  attr_reader :user, :record
  def update?
    record == user
  end
end
