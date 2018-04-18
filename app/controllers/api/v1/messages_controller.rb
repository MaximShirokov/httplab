# app/controllers/api/v1/messages_controller.rb

module Api::V1
  class MessagesController < BaseController

    # GET /v1/messages
    def index
      render json: Message.all
    end

    # POST /v1/messages
    def create
      message = Message.new(message_params.merge(user: current_user))

      if message.save
        response = { message: 'Message created successfully'}
        render json: response, status: :created
      else
        render json: message.errors, status: :bad
      end
    end

    private

      def message_params
        params.permit(:text)
      end
  end
end
