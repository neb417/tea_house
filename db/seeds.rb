# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do
  Customer.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    address: Faker::Address.full_address
  )
end

10.times do
  Tea.create!(
    title: Faker::Tea.variety,
    description: Faker::Hipster.sentence,
    temperature: Faker::Number.between(from: 90, to: 100),
    brew_time: Faker::Number.between(from: 120, to: 300)
  )
end

teas = Tea.all

# 1
Subscription.create!(
  customer_id: Customer.first.id,
  tea_id: Tea.first.id,
  title: Tea.first.title,
  price: Faker::Number.between(from: 500, to: 10_000),
  status: 0,
  frequency: [7, 14, 30].sample
)

# 2
Subscription.create!(
  customer_id: Customer.first.id,
  tea_id: Tea.second.id,
  title: Tea.second.title,
  price: Faker::Number.between(from: 500, to: 10_000),
  status: 0,
  frequency: [7, 14, 30].sample
)

# 3
Subscription.create!(
  customer_id: Customer.first.id,
  tea_id: Tea.third.id,
  title: Tea.third.title,
  price: Faker::Number.between(from: 500, to: 10_000),
  status: 1,
  frequency: [7, 14, 30].sample
)

# 4
Subscription.create!(
  customer_id: Customer.second.id,
  tea_id: Tea.fourth.id,
  title: Tea.fourth.title,
  price: Faker::Number.between(from: 500, to: 10_000),
  status: 0,
  frequency: [7, 14, 30].sample
)

# 5
Subscription.create!(
  customer_id: Customer.second.id,
  tea_id: Tea.fifth.id,
  title: Tea.fifth.title,
  price: Faker::Number.between(from: 500, to: 10_000),
  status: 0,
  frequency: [7, 14, 30].sample
)

# 6
Subscription.create!(
  customer_id: Customer.third.id,
  tea_id: teas[5].id,
  title: teas[5].title,
  price: Faker::Number.between(from: 500, to: 10_000),
  status: 0,
  frequency: [7, 14, 30].sample
)

# 7
Subscription.create!(
  customer_id: Customer.third.id,
  tea_id: teas[6].id,
  title: teas[6].title,
  price: Faker::Number.between(from: 500, to: 10_000),
  status: 0,
  frequency: [7, 14, 30].sample
)

# 8
Subscription.create!(
  customer_id: Customer.fourth.id,
  tea_id: teas[7].id,
  title: teas[7].title,
  price: Faker::Number.between(from: 500, to: 10_000),
  status: 0,
  frequency: [7, 14, 30].sample
)

# 9
Subscription.create!(
  customer_id: Customer.fourth.id,
  tea_id: teas[8].id,
  title: teas[8].title,
  price: Faker::Number.between(from: 500, to: 10_000),
  status: 0,
  frequency: [7, 14, 30].sample
)
