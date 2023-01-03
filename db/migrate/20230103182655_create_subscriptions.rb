# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :customer, foreign_key: true
      t.references :tea, foreign_key: true
      t.string :title
      t.integer :price # number of cents
      t.integer :status
      t.integer :frequency # number of days tea is sent out

      t.timestamps
    end
  end
end
