# frozen_string_literal: true
class Api::V1::UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :user_params, only: %i[create update]
  before_action :set_users, only: :index
  before_action :set_user, only: %i[show update destroy]

  def index
    render_success(data: @users)
  end

  def show
    render_success(data: @user)
  end

  def create
    user = User.create!(user_params)
    token = encode_token(user_id: user.id)
    user_data = { user: user, token: token[:token], expires: token[:expires] }

    render_success(data: user_data, status: :created)
  end

  def update
    @user.update!(user_params)

    render_success(data: @user, status: :ok)
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
