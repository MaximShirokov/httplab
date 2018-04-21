require 'rails_helper'

RSpec.describe ::Api::V1::Messages::VotesController, type: :controller do
  let!(:user) { create :user }
  let!(:messages) { FactoryGirl.create_list(:message, 1, user: user) }

  it 'GET /api/v1/messages/:message_id/vote' do
    @controller = Api::V1::AuthenticationController.new

    post :authenticate, params: {email: user.email, password: user.password}

    auth_token = JSON.parse(response.body)['auth_token']

    @controller = Api::V1::Messages::VotesController.new

    @request.headers['Authorization'] = auth_token

    rating = (1..5).to_a.sample

    post :create, params: {message_id: messages.first.id, rating: rating}

    expect(response.status).to eq(201)
    expect(response.message).to eq('Created')
    expect(response.body).to eq("{\"message\":\"Message #{messages.first.id} voted\"}")

    expect(Vote.first.message_id).to eq(messages.first.id)
    expect(Vote.first.user_id).to eq(user.id)
    expect(Vote.first.rating).to eq(rating)
  end
end
