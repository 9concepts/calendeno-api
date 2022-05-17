class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
    render json: user_info.to_h
  end
end
