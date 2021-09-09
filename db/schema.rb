# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_09_071837) do

  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "context"
    t.bigint "user_id", null: false
    t.bigint "court_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["court_id", "created_at"], name: "index_comments_on_court_id_and_created_at"
    t.index ["court_id"], name: "index_comments_on_court_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "name"
    t.text "address"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price"
    t.integer "hour"
    t.text "remarks"
    t.text "image"
    t.float "latitude"
    t.float "longitude"
    t.integer "number"
    t.index ["user_id"], name: "index_courts_on_user_id"
  end

  create_table "favorites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "court_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["court_id"], name: "index_favorites_on_court_id"
    t.index ["user_id", "court_id"], name: "index_favorites_on_user_id_and_court_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.text "image"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "courts"
  add_foreign_key "comments", "users"
  add_foreign_key "courts", "users"
  add_foreign_key "favorites", "courts"
  add_foreign_key "favorites", "users"
end
