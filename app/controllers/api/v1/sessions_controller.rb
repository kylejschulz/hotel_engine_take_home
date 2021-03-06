class Api::V1::SessionsController < ApplicationController
  def create
    if session_params[:email].nil?
      render json: "invalid credentials" , status: 422
      sleep 1
    else
      user = User.find_by(email: session_params[:email].downcase)
      if user && user.authenticate(session_params[:password])
        render json: UserSerializer.new(user), status: 200
        sleep 1
      else
        render json: "invalid credentials" , status: 422
        sleep 1
      end
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
