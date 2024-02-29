# frozen_string_literal: true

class Api::V1::PasswordsController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :password_params, only: :update

  def create
    Email::ResetPasswordService.call(params)
    render_success(data: { message: 'Send email for reset password!' }, status: :ok)
  end

  def update
    authorize current_user

    if authenticate?(current_user, params[:old_password])
      current_user.update(password: params[:password])

      render_success(data: user_data_with_token, status: :ok)
    else
      render_success(data: { errors: 'Wrong old password!' }, status: :not_acceptable)
    end
  end

  private

  def password_params
    params.permit(:password, :old_password, :email)
  end
end
