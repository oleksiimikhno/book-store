class Api::V1::AuthenticationsController < ApplicationController
  skip_before_action :authorize_request, only: :login

  def login
    user = User.find_by_email(user_params[:email])

    if authenticate?(user, params[:password])
      render_success(data: user_data_with_token(user))
    else
      render json: { erros: 'Wrong email or password!' }, status: :unauthorized
    end
  end

  def update_password
    if authenticate?(current_user, params[:old_password])
      current_user.update_attribute(:password, params[:password])

      render_success(data: user_data_with_token)
    else
      render json: { erros: 'Wrong old password!' }, status: :not_acceptable
    end
  end

  private

  def authenticate?(user, password)
    user&.authenticate(password)
  end

  def user_params
    params.permit(:email, :password, :old_password)
  end
end
