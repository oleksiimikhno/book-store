class Email::ResetPasswordService < ApplicationServices
  attr_reader :params

  def initialize(params)
    @params = params
    @user = set_user
  end

  def call
    raise StandardError, 'User not found!' unless @user.present?

    Email::ResetPasswordWorker.perform_async(@user)
  end

  private

  def set_user
    User.find_by(email: params[:email])
  end
end
