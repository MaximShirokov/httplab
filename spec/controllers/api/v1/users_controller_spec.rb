require 'rails_helper'

RSpec.describe ::Api::V1::UsersController, type: :controller do
  it 'success create a new user' do
    post :create, params: { email: 'test@mail.com', password: 'password' }

    expect(response.status).to eq(201)
    expect(response.message).to eq('Created')
    expect(response.body).to eq('{\"message\":\"User created successfully\"}')

    expect(User.count).to eq(1)
    expect(User.first.email).to eq('test@mail.com')
  end

  it 'fail create a new user' do
    post :create, params: { email: 'test@mail.com' }

    expect(response.status).to eq(422)
    expect(response.message).to eq('Internal Server Error')
    expect(response.body).to eq('{\'password_digest\':[\'can\'t be blank\'],\'password\':[\'can\'t be blank\']}')

    expect(User.count).to eq(0)
  end
end
