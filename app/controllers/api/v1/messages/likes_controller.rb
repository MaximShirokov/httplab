# app/controllers/api/v1/messages/likes_controller.rb

module Api::V1
  class Messages::LikesController < BaseController
    before_action :set_message

    def create
      @message.likes.where(user_id: current_user.id).first_or_create

      render json: { message: "Message #{@message.id} liked"}, status: :created
    end

    private

      def set_message
        @message = Message.find(params[:message_id])
      end
  end
end
