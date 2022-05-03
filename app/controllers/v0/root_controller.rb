class V0::RootController < ApplicationController
  def index
    render json: {message: 'hello'}
  end
end
