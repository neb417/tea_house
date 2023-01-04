# frozen_string_literal: true

class CustomerSerializer
  def self.new_customer(customer)
    {
      'data': {
        'id': customer.id,
        'first_name': customer.first_name,
        'last_name': customer.last_name,
        'email': customer.email,
        'address': customer.address
      }
    }
  end
end
