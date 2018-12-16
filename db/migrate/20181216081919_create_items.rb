class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :type, foreign_key: true, null: false
      t.string :name, null: false
      t.boolean :maki, default: true, null: false
      t.boolean :gyokai, default: true, null: false
      t.float :kotteri, null: false
      t.float :eat_frequency, null: false
      t.float :price, null: false
      t.float :sale_frequency, null: false

      t.timestamps
    end
  end
end
