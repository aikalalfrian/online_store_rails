class Api::UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:register, :login]

  def register
    user_params = params.require(:user).permit(:email, :password, :password_confirmation)
    result = UserService.new(:create, user_params).call

    if result[:errors]
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    else
      @user = User.find_by(email: user_params[:email])
      render 'api/users/register', status: :created
    end
  end

  def login
    result = UserService.new(:login, nil, params[:email], params[:password]).call

    if result[:error]
      render json: { error: result[:error] }, status: :unauthorized
    else
      @user = result[:user]
      render 'api/users/login', status: :ok
    end
  end

  def checkout_history
    user_service = UserService.new(:checkout_history)
    user_service.set_user(current_user)
    result = user_service.call

    render json: result, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
