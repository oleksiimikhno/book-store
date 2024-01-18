# frozen_string_literal: true
class Api::V1::UsersController < ApplicationController
  skip_before_action :authorize_request, only: %i[create]
  before_action :user_params, only: %i[create update]
  def index
    render_success(data: User.all, each_serializer: Api::V1::UserSerializer)
  end

  def show
    render_success(data: current_user, serializer: Api::V1::UserSerializer)
  end

  def create
    user = User.create!(user_params)
    render_success(data: user_data_with_token(user), status: :created)
  end

  def update
    current_user.update!(user_params)

    render_success(data: current_user, status: :ok, serializer: Api::V1::UserSerializer)
  end

  def destroy
    current_user.destroy

    render_success(data: { message: 'User successfully deleted' }, status: :ok)
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
