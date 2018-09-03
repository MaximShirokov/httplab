# frozen_string_literal: true

module ControllerMacros
  def auth
    # before(:each) do

    # end
    @controller = Api::V1::AuthenticationController.new

    post :authenticate, params: { email: user.email, password: user.password }

    auth_token = JSON.parse(response.body)['auth_token']

    @controller = Api::V1::MessagesController.new

    @request.headers['Authorization'] = auth_token
  end
end
