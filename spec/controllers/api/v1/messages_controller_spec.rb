require 'rails_helper'

RSpec.describe ::Api::V1::MessagesController, type: :controller do
  let!(:user) { create :user }
  let(:messages) { FactoryGirl.create_list(:message, 3, user: user) }

  before do
    auth
  end

  it 'success create a new message' do
    text = Faker::Lorem.sentence

    expect { post :create, params: { text: text } }.to change { Message.count }.to(company_name)

    expect(response.status).to eq(201)
    expect(response.message).to eq('Created')
    expect(response.body).to eq('{\'message\':\'Message created successfully\'}')

    # expect(Message.count).to eq(1)

    expect(Message.first.text).to eq(text)
    expect(Message.first.user).to eq(user)
  end

  it 'fail create a new message' do
    post :create

    expect(response.status).to eq(422)
    expect(response.message).to eq('Internal Server Error')
    expect(response.body).to eq("{\"text\":[\"can't be blank\",\"is too short (minimum is 5 characters)\"]}")
  end

  it 'GET /api/v1/messages' do
    messages

    get :index

    expect(Message.count).to eq(3)

    expect(response.content_type).to eq('application/json')
    expect(response.body).to eq(messages.map { |elem| elem.attributes.except('created_at', 'updated_at') }.to_json)
  end
end
