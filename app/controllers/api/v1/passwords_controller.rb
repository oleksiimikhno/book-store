# frozen_string_literal: true

class Api::V1::PasswordsController < ApplicationController
  before_action :password_params, only: :update

  def update
    authorize current_user

    if authenticate?(current_user, params[:old_password])
      current_user.update(password: params[:password])

      render_success(data: user_data_with_token)
    else
      render json: { errors: 'Wrong old password!' }, status: :not_acceptable
    end
  end

  private

  def password_params
    params.permit(:password, :old_password)
  end
end
