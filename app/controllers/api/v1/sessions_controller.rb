class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    user = User.find_by_email(user_params[:email])

    if authenticate?(user, params[:password])
      render_success(data: user_data_with_token(user))
    else
      render json: { erros: 'Wrong email or password!' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password, :old_password)
  end
end
