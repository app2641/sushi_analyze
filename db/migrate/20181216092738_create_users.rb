class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :uid, null: false
      t.integer :gender, null: false, default: 0
      t.integer :age, null: false, default: 0
      t.integer :answer_time, null: false, default: 0
      t.references :prefecture, foreign_key: true, null: false
      t.references :region, foreign_key: true, null: false
      t.integer :ew, null: false, default: 0
      t.references :origin_prefecture, foreign_key: { to_table: :prefectures }, null: false
      t.references :origin_region, foreign_key: { to_table: :regions }, null: false
      t.integer :origin_ew, null: false, default: 0
      t.boolean :permanent, null: false, default: 0

      t.timestamps
    end
  end
end
