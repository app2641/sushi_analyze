# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false
      t.integer :rank, null: false

      t.timestamps
    end
  end
end
