class Api::V1::AuthenticationsController < ApplicationController
  skip_before_action :authorize_request

  def login
    user = User.find_by_email(user_params[:email])

    return unless user&.authenticate(params[:password])

    token = encode_token(user_id: user.id)
    user_data = { user: user, token: token[:token], expires: token[:expires] }

    render_success(data: user_data)
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
