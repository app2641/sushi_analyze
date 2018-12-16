# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_16_104049) do

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "type_id", null: false
    t.string "name", null: false
    t.boolean "maki", default: true, null: false
    t.boolean "gyokai", default: true, null: false
    t.float "kotteri", null: false
    t.float "eat_frequency", null: false
    t.float "price", null: false
    t.float "sale_frequency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type_id"], name: "index_items_on_type_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.integer "rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_orders_on_item_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "prefectures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "uid", null: false
    t.integer "gender", default: 0, null: false
    t.integer "age", default: 0, null: false
    t.integer "answer_time", default: 0, null: false
    t.bigint "prefecture_id", null: false
    t.bigint "region_id", null: false
    t.integer "ew", default: 0, null: false
    t.bigint "origin_prefecture_id", null: false
    t.bigint "origin_region_id", null: false
    t.integer "origin_ew", default: 0, null: false
    t.boolean "permanent", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["origin_prefecture_id"], name: "index_users_on_origin_prefecture_id"
    t.index ["origin_region_id"], name: "index_users_on_origin_region_id"
    t.index ["prefecture_id"], name: "index_users_on_prefecture_id"
    t.index ["region_id"], name: "index_users_on_region_id"
  end

  add_foreign_key "items", "types"
  add_foreign_key "orders", "items"
  add_foreign_key "orders", "users"
  add_foreign_key "users", "prefectures"
  add_foreign_key "users", "prefectures", column: "origin_prefecture_id"
  add_foreign_key "users", "regions"
  add_foreign_key "users", "regions", column: "origin_region_id"
end
