# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create subscriptions' do
  let!(:subscription) { create :subscription, status: 0 }

  describe 'happy path testing' do
    it 'updates status of subscription' do
      customer = Customer.first

      expect(customer.subscriptions.first.cancelled?).to be false

      sub_params = {
        'id': subscription.id,
        'customer_id': subscription.customer.id,
        'tea_id': subscription.tea.id,
        'title': subscription.tea.title,
        'price': subscription.price,
        'frequency': subscription.frequency,
        'status': 1
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch api_v1_subscription_path(subscription), headers: headers, params: JSON.generate(sub_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq 200

      expect(subscription_response[:data]).to have_key :success
      expect(subscription_response[:data][:success]).to eq('Your subscriptions have been updated')
      expect(customer.subscriptions.first.cancelled?).to be true
      expect(customer.subscriptions.size).to eq 1
    end
  end

  describe 'sad path testing' do
    it 'subscription does not update with incorrect customer id' do
      sub_params = {
        'id': subscription.id,
        'customer_id': 0,
        'tea_id': subscription.tea.id,
        'title': subscription.tea.title,
        'price': subscription.price,
        'frequency': subscription.frequency,
        'status': 0
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch api_v1_subscription_path(subscription), headers: headers, params: JSON.generate(sub_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq 400

      expect(subscription_response[:data]).to have_key :error
      expect(subscription_response[:data][:error]).to eq('Customer must exist')
    end

    it 'subscription does not update with invalid tea id' do
      sub_params = {
        'id': subscription.id,
        'customer_id': subscription.customer.id,
        'tea_id': 0,
        'title': subscription.tea.title,
        'price': subscription.price,
        'frequency': subscription.frequency,
        'status': 0
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch api_v1_subscription_path(subscription), headers: headers, params: JSON.generate(sub_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq 400

      expect(subscription_response[:data]).to have_key :error
      expect(subscription_response[:data][:error]).to eq('Tea must exist')
    end

    it 'subscription does not update with invalid frequency, float' do
      sub_params = {
        'id': subscription.id,
        'customer_id': subscription.customer.id,
        'tea_id': subscription.tea.id,
        'title': subscription.tea.title,
        'price': subscription.price,
        'frequency': 2.0,
        'status': 0
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch api_v1_subscription_path(subscription), headers: headers, params: JSON.generate(sub_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq 400

      expect(subscription_response[:data]).to have_key :error
      expect(subscription_response[:data][:error]).to eq('Frequency must be an integer')
    end

    it 'subscription does not update with invalid frequency, string' do
      sub_params = {
        'id': subscription.id,
        'customer_id': subscription.customer.id,
        'tea_id': subscription.tea.id,
        'title': subscription.tea.title,
        'price': subscription.price,
        'frequency': 'seven',
        'status': 0
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch api_v1_subscription_path(subscription), headers: headers, params: JSON.generate(sub_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq 400

      expect(subscription_response[:data]).to have_key :error
      expect(subscription_response[:data][:error]).to eq('Frequency is not a number')
    end
  end
end
