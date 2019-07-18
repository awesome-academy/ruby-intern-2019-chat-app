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

ActiveRecord::Schema.define(version: 2019_07_20_132833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.bigint "request_sender_id"
    t.bigint "request_receiver_id"
    t.integer "status"
    t.index ["request_receiver_id"], name: "index_contacts_on_request_receiver_id"
    t.index ["request_sender_id"], name: "index_contacts_on_request_sender_id"
  end

  create_table "file_images", force: :cascade do |t|
    t.bigint "message_id"
    t.bigint "room_id"
    t.string "file"
    t.index ["message_id"], name: "index_file_images_on_message_id"
    t.index ["room_id"], name: "index_file_images_on_room_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "user_id"
    t.string "content"
    t.integer "type"
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.bigint "user_id"
    t.integer "status"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "owner_id"
    t.integer "type"
  end

  create_table "user_rooms", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "user_id"
    t.boolean "admin"
    t.index ["room_id"], name: "index_user_rooms_on_room_id"
    t.index ["user_id"], name: "index_user_rooms_on_user_id"
  end

  create_table "user_seens", force: :cascade do |t|
    t.bigint "message_id"
    t.bigint "user_id"
    t.integer "status"
    t.index ["message_id"], name: "index_user_seens_on_message_id"
    t.index ["user_id"], name: "index_user_seens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.datetime "birthday"
    t.integer "gender"
    t.string "avatar"
    t.boolean "admin"
    t.string "username"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contacts", "users", column: "request_receiver_id"
  add_foreign_key "contacts", "users", column: "request_sender_id"
  add_foreign_key "file_images", "messages"
  add_foreign_key "file_images", "rooms"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "user_rooms", "rooms"
  add_foreign_key "user_rooms", "users"
  add_foreign_key "user_seens", "messages"
  add_foreign_key "user_seens", "users"
end
