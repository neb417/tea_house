# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    tea
    customer

    title { Faker::Tea.variety }
    price { Faker::Number.between(from: 500, to: 10_000) }
    status { rand(0..1) }
    frequency { [7, 14, 30].sample }
  end
end
