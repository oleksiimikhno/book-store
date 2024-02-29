# frozen_string_literal: true

class SubscriptionPolicy < ApplicationPolicy
  def show?
    @user == @record.user
  end
end
