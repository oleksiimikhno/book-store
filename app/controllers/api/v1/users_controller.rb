# frozen_string_literal: true
class Api::V1::UsersController < ApplicationController
  skip_before_action :authorize_request, only: %i[create destroy]
  before_action :user_params, only: %i[create update]
  before_action :set_users, only: :index

  def show
    render_success(data: @user, serializer: Api::V1::UserSerializer)
  end

  def create
    user = User.create!(user_params)
    render_success(data: user_data_with_token(user), status: :created)
  end

  def update
    @user.update!(user_params)

    render_success(data: @user, status: :ok, serializer: Api::V1::UserSerializer)
  end

  def destroy
    @user.destroy!

    render_success(data: { message: 'User successfully deleted' }, status: :ok)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_users
    @users = User.all
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
