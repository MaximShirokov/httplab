# frozen_string_literal: true

# app/controllers/api/v1/messages_controller.rb

module Api
  module V1
    class MessagesController < Api::V1::BaseController
      # GET /v1/messages
      def index
        render json: Message.all
      end

      # POST /v1/messages
      def create
        message = Message.new(message_params.merge(user: current_user))

        if message.save
          response = { message: 'Message created successfully' }
          render json: response, status: :created
        else
          render json: message.errors, status: :unprocessable_entity
        end
      end

      private

      def message_params
        params.permit(:text)
      end
    end
  end
end
