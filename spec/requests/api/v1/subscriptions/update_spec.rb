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

      put api_v1_subscription_path(subscription), headers: headers, params: JSON.generate(subscription: sub_params)

      subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq 200

      expect(subscription_response[:data]).to have_key :success
      expect(subscription_response[:data][:success]).to eq('Your subscriptions have been updated')
      expect(customer.subscriptions.first.cancelled?).to be true
      expect(customer.subscriptions.size).to eq 1
    end
  end
end
