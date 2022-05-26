class SessionsController < ApplicationController
  def create
    user = User.find_or_initialize_by(email: user_params[:email])
    # NOTE: Create or update the user.
    user.update(user_params)

    # TODO: 暫定的にユーザー情報を返している。
    render json: UserResource.new(user).serialize
  end

  private

  def user_params
    auth_hash = request.env["omniauth.auth"].with_indifferent_access
    id_token = auth_hash[:extra][:id_info]
    raw_info = auth_hash[:extra][:raw_info]
    info = auth_hash[:info]

    {
      email: id_token[:email],
      name: raw_info[:name],
      image: id_token[:picture] || info[:image],
      iss: id_token[:iss],
      sub: id_token[:sub]
    }
  end
end
