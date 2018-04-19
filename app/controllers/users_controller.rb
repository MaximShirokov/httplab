class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def index
    @period = params[:period].to_sym

    @users = {
      top_by_messages: User.top_by_messages(period),
      top_by_likes: User.top_by_likes(period),
    }
  end
end
