# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @period = params[:period]&.to_sym

    @users = {
      top_by_messages: User::TopByRelation.new(User.all).call(relation: :messages, period: @period),
      top_by_votes: User::TopByRelation.new(User.all).call(relation: :votes, period: @period)
    }

    render json: @users
  end
end
