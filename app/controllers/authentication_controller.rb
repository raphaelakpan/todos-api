class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  # authenticate the user and return a token
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    response = { message: 'Login Successful!', auth_token: auth_token }
    json_response(response)
  end

  private
  # permit email and password in the parameters
  def auth_params
    params.permit(:email, :password)
  end
end
