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

      post api_v1_customers_path, headers: headers, params: JSON.generate(customer_params)

      customer_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(customer_response[:data]).to have_key :id
      expect(customer_response[:data]).to have_key :first_name
      expect(customer_response[:data]).to have_key :last_name
      expect(customer_response[:data]).to have_key :email
      expect(customer_response[:data]).to have_key :address
    end
  end

  describe 'sad paths' do
    it 'returns error with missing first/last name' do
      customer_params = {
        'email': Faker::Internet.free_email,
        'address': Faker::Address.full_address
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post api_v1_customers_path, headers: headers, params: JSON.generate(customer_params)

      customer_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(customer_response[:data]).to have_key :error
      expect(customer_response[:data][:error]).to eq("First name can't be blank and Last name can't be blank")
    end

    it 'returns error with existing customer email' do
      create(:customer)
      customer_params = {
        'first_name': Faker::Name.first_name,
        'last_name': Faker::Name.last_name,
        'email': Customer.last.email,
        'address': Faker::Address.full_address
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post api_v1_customers_path, headers: headers, params: JSON.generate(customer_params)

      customer_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(customer_response[:data]).to have_key :error
      expect(customer_response[:data][:error]).to eq('Email has already been taken')
    end

    it 'returns error with missing address' do
      customer_params = {
        'first_name': Faker::Name.first_name,
        'last_name': Faker::Name.last_name,
        'email': Faker::Internet.free_email
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post api_v1_customers_path, headers: headers, params: JSON.generate(customer_params)

      customer_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(customer_response[:data]).to have_key :error
      expect(customer_response[:data][:error]).to eq("Address can't be blank")
    end
  end
end
