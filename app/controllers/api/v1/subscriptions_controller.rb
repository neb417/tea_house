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
          # binding.pry
          render json: { data: { error: subscription.errors.full_messages.to_sentence } }, status: 400
        end
      end

      private

      def subscription_params
        params.require(:subscription).permit(
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
