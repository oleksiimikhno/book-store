class User::CreateService < ApplicationServices
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    user = User.find_by(email: params[:email])
    raise StandardError, 'User already exists' if user.present?

    User.create!(params)
  end
end
