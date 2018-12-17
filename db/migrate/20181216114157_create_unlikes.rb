# frozen_string_literal: true

class CreateUnlikes < ActiveRecord::Migration[5.2]
  def change
    create_table :unlikes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false

      t.timestamps
    end
  end
end
