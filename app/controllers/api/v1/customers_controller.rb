# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      def create
        customer = Customer.new(customer_params)

        if customer.save
          render json: CustomerSerializer.new_customer(customer)
        else
          render json: { 'data': { 'error': customer.errors.full_messages.to_sentence } }
        end
      end

      private

      def customer_params
        params.require(:customer).permit(
          :first_name,
          :last_name,
          :email,
          :address
        )
      end
    end
  end
end
