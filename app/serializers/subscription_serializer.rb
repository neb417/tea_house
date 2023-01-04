# frozen_string_literal: true

class SubscriptionSerializer
  def self.new_subscription(subscription)
    {
      'data': {
        'id': subscription.id,
        'price': subscription.price,
        'status': subscription.status,
        'frequency': subscription.frequency,
        'title': subscription.title,
        'tea': {
          'title': subscription.tea.title,
          'description': subscription.tea.description,
          'temperature': subscription.tea.temperature,
          'brew_time': subscription.tea.brew_time
        }
      }
    }
  end

  def self.customer_subscriptions(subscriptions)
    {
      'data': {
        'subscriptions':
          subscriptions.map do |subscription|
            {
              'id': subscription.id,
              'price': subscription.price,
              'status': subscription.status,
              'frequency': subscription.frequency,
              'title': subscription.title,
              'tea': {
                'title': subscription.tea.title,
                'description': subscription.tea.description,
                'temperature': subscription.tea.temperature,
                'brew_time': subscription.tea.brew_time
              }
            }
          end
      }
    }
  end
end
