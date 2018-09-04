# frozen_string_literal: true

# app/controllers/api/v1/messages/votes_controller.rb

module Api
  module V1
    module Messages
      class VotesController < Api::V1::BaseController
        before_action :set_message

        def create
          @message.votes.where(user_id: current_user.id).first_or_create(rating: params[:rating].to_i)

          render json: { message: "Message #{@message.id} voted" }, status: :created
        end

        private

        def set_message
          @message = Message.find(params[:message_id])
        end
      end
    end
  end
end
