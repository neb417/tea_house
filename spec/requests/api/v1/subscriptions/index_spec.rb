# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create subscriptions' do
  let!(:customers) { create_list :customer, 2 }
  let!(:customer1) { customers.first }
  let!(:customer2) { customers.last }

  let!(:teas) { create_list :tea, 2 }
  let!(:tea1) { teas.first }
  let!(:tea2) { teas.last }

  let!(:sub1) { create :subscription, customer_id: customer1.id, tea_id: tea1.id, status: 0 }
  let!(:sub2) { create :subscription, customer_id: customer1.id, tea_id: tea2.id, status: 1 }

  describe 'response has all customer subscriptions' do
    it 'returns all subscriptions' do
      expect(customer1.subscriptions.size).to eq 2
      expect(customer2.subscriptions.size).to eq 0

      customer_info = {
        'customer_id': customer1.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      get api_v1_subscriptions_path(customer_info), headers: headers

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(subscription_response[:data]).to have_key :subscriptions
      expect(subscription_response[:data][:subscriptions]).to be_an Array
      expect(subscription_response[:data][:subscriptions].count).to eq 2

      expect(subscription_response[:data][:subscriptions].first).to have_key :id
      expect(subscription_response[:data][:subscriptions].first).to have_key :price
      expect(subscription_response[:data][:subscriptions].first).to have_key :status
      expect(subscription_response[:data][:subscriptions].first).to have_key :frequency
      expect(subscription_response[:data][:subscriptions].first).to have_key :title
      expect(subscription_response[:data][:subscriptions].first).to have_key :tea
      expect(subscription_response[:data][:subscriptions].first[:tea]).to have_key :title
      expect(subscription_response[:data][:subscriptions].first[:tea]).to have_key :description
      expect(subscription_response[:data][:subscriptions].first[:tea]).to have_key :temperature
      expect(subscription_response[:data][:subscriptions].first[:tea]).to have_key :brew_time
    end

    it 'returns empty array when there are 0 subscriptions' do
      expect(customer1.subscriptions.size).to eq 2
      expect(customer2.subscriptions.size).to eq 0

      customer_info = {
        'customer_id': customer2.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      get api_v1_subscriptions_path(customer_info), headers: headers

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(subscription_response[:data]).to have_key :subscriptions

      expect(subscription_response[:data][:subscriptions]).to be_an Array
      expect(subscription_response[:data][:subscriptions].empty?).to eq true
      expect(subscription_response[:data][:subscriptions].count).to eq 0
    end
  end
end
