# frozen_string_literal: true

class CreateTeas < ActiveRecord::Migration[5.2]
  def change
    create_table :teas do |t|
      t.string :title
      t.string :description
      t.integer :temperature # temp C
      t.integer :brew_time # number of minutes

      t.timestamps
    end
  end
end
