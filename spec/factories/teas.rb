# frozen_string_literal: true

FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Hipster.sentence }
    temperature { Faker::Number.between(from: 90, to: 100) }
    brew_time { Faker::Number.between(from: 120, to: 300) }
  end
end
