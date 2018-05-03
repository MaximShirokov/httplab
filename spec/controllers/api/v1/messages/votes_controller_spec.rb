require 'rails_helper'

RSpec.describe ::Api::V1::Messages::VotesController, type: :controller do
  let!(:user) { create :user }
  let!(:message) { create :message, user: user }

  it 'GET /api/v1/messages/:message_id/vote' do
    @controller = Api::V1::AuthenticationController.new

    post :authenticate, params: { email: user.email, password: user.password }

    auth_token = JSON.parse(response.body)['auth_token']

    @controller = Api::V1::Messages::VotesController.new

    @request.headers['Authorization'] = auth_token

    rating = (1..5).to_a.sample

    post :create, params: { message_id: message.id, rating: rating }

    expect(response.status).to eq(201)
    expect(response.message).to eq('Created')
    expect(response.body).to eq("{\"message\":\"Message #{message.id} voted\"}")

    expect(Vote.first.message_id).to eq(message.id)
    expect(Vote.first.user_id).to eq(user.id)
    expect(Vote.first.rating).to eq(rating)
  end
end
