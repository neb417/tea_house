# frozen_string_literal: true

class Subscription < ApplicationRecord
  validates_presence_of :customer_id
  validates_presence_of :tea_id
  validates_presence_of :title
  validates_numericality_of :price, only_integer: true
  validates_presence_of :status
  validates_numericality_of :frequency, only_integer: true

  belongs_to :customer
  belongs_to :tea

  enum status: %i[active cancelled]
end
