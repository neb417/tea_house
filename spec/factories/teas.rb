# frozen_string_literal: true

FactoryBot.define do
  factory :tea do
    title { 'MyString' }
    description { 'MyString' }
    temperature { 1 }
    brew_time { 1 }
  end
end
