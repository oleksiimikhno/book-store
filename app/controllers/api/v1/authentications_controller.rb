class Api::V1::AuthenticationsController < ApplicationController
  skip_before_action :authorize_request

  def login
    user = User.find_by_email(user_params[:email])

    if user&.authenticate(params[:password])
      token = encode_token(user_id: user.id)
      user_data = { user: user, token: token[:token], expires: token[:expires] }

      render_success(data: user_data)
    else
      render json: { erros: 'Wrong email or password!' }, status: :unauthorized
    end
  end

  def update_password

  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
