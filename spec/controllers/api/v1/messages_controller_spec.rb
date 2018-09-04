# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Api::V1::MessagesController, type: :controller do
  extend ControllerMacros

  let!(:user) { create :user }
  let(:messages) { FactoryGirl.create_list(:message, 3, user: user) }

  before do
    @controller = Api::V1::AuthenticationController.new

    post :authenticate, params: { email: user.email, password: user.password }

    auth_token = JSON.parse(response.body)['auth_token']

    @controller = Api::V1::MessagesController.new

    @request.headers['Authorization'] = auth_token
  end

  describe 'create' do
    it 'success' do
      text = Faker::Lorem.sentence

      expect { post :create, params: { text: text } }.to change { Message.count }.to(1)

      expect(response.status).to eq(201)
      expect(response.message).to eq('Created')
      expect(response.body).to eq("{\"message\":\"Message created successfully\"}")

      # expect(Message.count).to eq(1)

      expect(Message.first.text).to eq(text)
      expect(Message.first.user).to eq(user)
    end

    it 'fail' do
      post :create

      expect(response.status).to eq(422)
      expect(response.message).to eq('Unprocessable Entity')
      expect(response.body).to eq("{\"text\":[\"can't be blank\",\"is too short (minimum is 5 characters)\"]}")
    end
  end

  describe 'index' do
    it 'GET /api/v1/messages' do
      messages

      get :index

      expect(Message.count).to eq(3)

      expect(response.content_type).to eq('application/json')
      expect(response.body).to eq(messages.map { |elem| elem.attributes.except('created_at', 'updated_at') }.to_json)
    end
  end
end
