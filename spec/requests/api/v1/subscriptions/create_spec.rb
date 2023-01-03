# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create subscriptions' do
  let!(:customers) { create_list :customer, 3 }
  let!(:teas) { create_list :tea, 5 }

  describe 'happy path testing' do
    it 'customer subscribes to a tea' do
      sub_params = {
        'customer_id': customers.first.id,
        'tea_id': teas.first.id,
        'title': teas.first.title,
        'price': 599,
        'frequency': 14
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription: sub_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      user = customers.first

      expect(user.subscriptions.count).to eq 1
      expect(user.subscriptions.first.active?).to be true

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(subscription_response[:data]).to have_key :id
      expect(subscription_response[:data]).to have_key :price
      expect(subscription_response[:data]).to have_key :status
      expect(subscription_response[:data]).to have_key :frequency
      expect(subscription_response[:data]).to have_key :title
      expect(subscription_response[:data]).to have_key :tea
      expect(subscription_response[:data][:tea]).to have_key :title
      expect(subscription_response[:data][:tea]).to have_key :description
      expect(subscription_response[:data][:tea]).to have_key :temperature
      expect(subscription_response[:data][:tea]).to have_key :brew_time
    end
  end

  describe 'sad path testing' do
    it 'error with missing customer id' do
      sub_params = {
        'tea_id': teas.first.id,
        'title': teas.first.title,
        'price': 599,
        'frequency': 14
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription: sub_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      user = customers.first

      expect(user.subscriptions.count).to eq 0

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(subscription_response).to have_key(:data)
      expect(subscription_response[:data]).to have_key(:error)
      expect(subscription_response[:data][:error]).to eq('Customer must exist')
    end

    it 'error with missing tea id' do
      sub_params = {
        'customer_id': customers.first.id,
        'title': teas.first.title,
        'price': 599,
        'frequency': 14
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription: sub_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      user = customers.first

      expect(user.subscriptions.count).to eq 0

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(subscription_response).to have_key(:data)
      expect(subscription_response[:data]).to have_key(:error)
      expect(subscription_response[:data][:error]).to eq('Tea must exist')
    end

    it 'error with missing price' do
      sub_params = {
        'customer_id': customers.first.id,
        'tea_id': teas.first.id,
        'title': teas.first.title,
        'frequency': 14
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription: sub_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      user = customers.first

      expect(user.subscriptions.count).to eq 0

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(subscription_response).to have_key(:data)
      expect(subscription_response[:data]).to have_key(:error)
      expect(subscription_response[:data][:error]).to eq("Price can't be blank")
    end

    it 'error with missing frequency' do
      sub_params = {
        'customer_id': customers.first.id,
        'tea_id': teas.first.id,
        'title': teas.first.title,
        'price': 599
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post api_v1_subscriptions_path, headers: headers, params: JSON.generate(subscription: sub_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      user = customers.first

      expect(user.subscriptions.count).to eq 0

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(subscription_response).to have_key(:data)
      expect(subscription_response[:data]).to have_key(:error)
      expect(subscription_response[:data][:error]).to eq("Frequency can't be blank")
    end
  end
end
