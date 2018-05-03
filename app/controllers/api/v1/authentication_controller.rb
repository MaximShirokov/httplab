# app/controllers/api/v1/authentication_controller.rb

module Api
  module V1
    class AuthenticationController < Api::V1::BaseController
      skip_before_action :authenticate_request

      def authenticate
        command = AuthenticateUser.call(params[:email], params[:password])

        if command.success?
          render json: { auth_token: command.result }
        else
          render json: { error: command.errors }, status: :unauthorized
        end
      end
    end
  end
end
