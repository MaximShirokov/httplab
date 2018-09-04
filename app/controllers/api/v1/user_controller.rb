# frozen_string_literal: true

# app/controllers/api/v1/users_controller.rb

module Api
  module V1
    class UserController < Api::V1::BaseController
      skip_before_action :authenticate_request, only: :create

      # POST /api/v1/create
      def create
        user = User.new(user_params)

        if user.save
          response = { message: 'User created successfully' }
          render json: response, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(
          :name,
          :email,
          :password
        )
      end
    end
  end
end
