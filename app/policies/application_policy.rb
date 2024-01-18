# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  alias show? index?
  alias create? index?
  alias new? index?
  alias update? index?
  alias edit? index?
  alias destroy? index?
end
