class SessionsController < ApplicationController
  def create
    user_info = request.env["omniauth.auth"]

    user = User.find_or_initialize_by(email: user_info["email"])
    # NOTE: Create or update the user.
    user.attributes = user_params
    user.save

    # TODO: 暫定的にユーザー情報を返している。
    render json: UserResource.new(user).serialize
  end

  private

  def user_params
    id_token = request.env["omniauth.auth"]["extra"]["id_info"]

    {
      email: id_token["email"],
      name: id_token["name"],
      image: id_token["picture"],
      iss: id_token["iss"],
      sub: id_token["sub"]
    }
  end
end
