# app/controllers/api/v1/users_controller.rb

module Api::V1
  class UsersController < BaseController
    skip_before_action :authenticate_request, only: :register

    # POST /api/v1/register
    def register
      user = User.new(user_params)

      if user.save
        response = { message: 'User created successfully'}
        render json: response, status: :created
      else
        render json: user.errors, status: :bad
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
