class Api::V1::UsersController < ActionController::API
  # before_action :check_subscriptions, only: :show
  require 'json_web_token'

  def login
    user = User.find_by(email: params[:email].to_s.downcase)
    if user && user.valid_password?(params[:password])
      auth_token = JsonWebToken.encode({user_id: user.id})
      render json: {auth_token: auth_token}, status: :ok
    else
      render json: {error: 'Invalid username / password'}, status: :unauthorized
    end
  end

end
