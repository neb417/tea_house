# frozen_string_literal: true

module Api
  module V1
    class SubscriptionsController < ApplicationController
      def create
        subscription = Subscription.new(subscription_params)

        subscription.status = 0
        if subscription.save
          render json: SubscriptionSerializer.new_subscription(subscription)
        else
          render json: { data: { error: subscription.errors.full_messages.to_sentence } }, status: 400
        end
      end

      def update
        subscription = Subscription.find(params[:id])
        if subscription.update(subscription_params)
          render json: { 'data': { 'success': 'Your subscriptions have been updated' } }
        else
          render json: { 'data': { 'error': subscription.errors.full_messages.to_sentence } }, status: 400
        end
      end

      def index
        customer = Customer.find(params[:customer_id])
        subscriptions = customer.subscriptions
        render json: SubscriptionSerializer.customer_subscriptions(subscriptions)
      end

      private

      def subscription_params
        params.permit(
          :customer_id,
          :tea_id,
          :title,
          :price,
          :frequency,
          :status
        )
      end
    end
  end
end
