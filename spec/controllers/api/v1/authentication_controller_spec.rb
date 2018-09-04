# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Api::V1::AuthenticationController, type: :controller do
  let!(:user) { create :user }

  it 'success user authenticate' do
    post :authenticate, params: { email: user.email, password: user.password }

    expect(response.status).to eq(200)
    expect(response.message).to eq('OK')
    expect(JSON.parse(response.body).key?('auth_token')).to eq(true)
  end

  it 'fail user authenticate' do
    post :authenticate, params: { email: user.email }

    expect(response.status).to eq(401)
    expect(response.message).to eq('Unauthorized')
    expect(response.body).to eq("{\"error\":{\"user_authentication\":[\"invalid credentials\"]}}")
  end
end
