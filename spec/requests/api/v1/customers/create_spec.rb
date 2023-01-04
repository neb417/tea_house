# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create subscriptions' do
  describe 'happy path for creating user' do
    it 'returns user' do
      customer_params = {
        'first_name': Faker::Name.first_name,
        'last_name': Faker::Name.last_name,
        'email': Faker::Internet.free_email,
        'address': Faker::Address.full_address
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post api_v1_users_path, headers: headers, params: JSON.generate(customer_params)

      customer_response = JSON.parse(response.body, symbolize_names: true)

      expect(User.size).to eq 1

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(customer_response[:data]).to have_key :id
      expect(customer_response[:data]).to have_key :first_name
      expect(customer_response[:data]).to have_key :last_name
      expect(customer_response[:data]).to have_key :email
      expect(customer_response[:data]).to have_key :address
    end
  end
end