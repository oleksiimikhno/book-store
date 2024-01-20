# frozen_string_literal: true


class Api::V1::PasswordsController < ApplicationController
  def update
    authorize params[:old_password]

    if authenticate?(current_user, params[:old_password])
      current_user.update_attribute(:password, params[:password])

      render_success(data: user_data_with_token)
    else
      render json: { errors: 'Wrong old password!' }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.permit(:email, :password, :old_password)
  end
end
