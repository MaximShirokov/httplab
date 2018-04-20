# app/controllers/api/v1/messages/votes_controller.rb

module Api::V1
  class Messages::VotesController < BaseController
    before_action :set_message

    def create
      @message.votes.where(user_id: current_user.id).first_or_create(rating: params[:rating].to_i)

      render json: { message: "Message #{@message.id} liked"}, status: :created
    end

    private

      def set_message
        @message = Message.find(params[:message_id])
      end
  end
end
