class AuthenticationController < ApplicationController
  # authenticate the user and return a token
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_responce(auth_token: auth_token)
  end

  private
  # permit email and password in the parameters
  def auth_params
    params.permit(:email, :password)
  end
end
