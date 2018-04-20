class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def index
    @period = params[:period].to_sym

    @users = {
      top_by_messages: User.top_by(:messages, period),
      top_by_votes: User.top_by(:votes, period),
    }
  end
end
