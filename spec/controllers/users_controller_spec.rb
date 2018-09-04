# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:users) { FactoryGirl.create_list(:user, 3) }
  let!(:messages1) { FactoryGirl.create_list(:message, 5, user: users.first) }
  let!(:messages2) { FactoryGirl.create_list(:message, 3, user: users.second) }
  let!(:messages3) { FactoryGirl.create_list(:message, 1, user: users.third) }

  it 'index render top users' do
    get :index

    top_by_messages = JSON.parse(response.body)['top_by_messages']

    expect(top_by_messages.pluck('id')).to eq(users.pluck(:id))
  end
end
