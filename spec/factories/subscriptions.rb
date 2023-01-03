# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    customer { nil }
    tea { nil }
    title { 'MyString' }
    price { 1 }
    status { 1 }
    frequency { 1 }
  end
end
