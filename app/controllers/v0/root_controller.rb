class V0::RootController < ApplicationController
  skip_before_action :check_logged_in, only: :index
  
  def index
    render json: {message: 'hello'}
  end
end
