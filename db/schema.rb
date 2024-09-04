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

ActiveRecord::Schema[7.2].define(version: 2024_09_03_094720) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_programs", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "location", null: false
    t.string "attendance_token", null: false
    t.string "public_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendance_token"], name: "index_event_programs_on_attendance_token", unique: true
    t.index ["event_id"], name: "index_event_programs_on_event_id"
    t.index ["public_id"], name: "index_event_programs_on_public_id", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "description", null: false
    t.datetime "location", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.boolean "is_cancelled", default: false, null: false
    t.string "attendance_token", null: false
    t.string "public_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendance_token"], name: "index_events_on_attendance_token", unique: true
    t.index ["public_id"], name: "index_events_on_public_id", unique: true
  end

  create_table "kc32024_stamp_collects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "kc32024_stamp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kc32024_stamp_id"], name: "index_kc32024_stamp_collects_on_kc32024_stamp_id"
    t.index ["user_id"], name: "index_kc32024_stamp_collects_on_user_id"
  end

  create_table "kc32024_stamps", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "collection_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_token"], name: "index_kc32024_stamps_on_collection_token", unique: true
  end

  create_table "user_event_attendances", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_user_event_attendances_on_event_id"
    t.index ["user_id"], name: "index_user_event_attendances_on_user_id"
  end

  create_table "user_login_tokens", force: :cascade do |t|
    t.bigint "discord_id", null: false
    t.string "token", null: false
    t.datetime "expired_at", null: false
    t.boolean "is_used", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discord_id"], name: "index_user_login_tokens_on_discord_id"
    t.index ["token"], name: "index_user_login_tokens_on_token", unique: true
  end

  create_table "user_program_attendances", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_program_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_program_id"], name: "index_user_program_attendances_on_event_program_id"
    t.index ["user_id"], name: "index_user_program_attendances_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "discord_id", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.string "email", null: false
    t.string "school_name"
    t.integer "graduation_year"
    t.string "circle_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discord_id"], name: "index_users_on_discord_id", unique: true
  end

  add_foreign_key "event_programs", "events"
  add_foreign_key "kc32024_stamp_collects", "kc32024_stamps"
  add_foreign_key "kc32024_stamp_collects", "users"
  add_foreign_key "user_event_attendances", "events"
  add_foreign_key "user_event_attendances", "users"
  add_foreign_key "user_program_attendances", "event_programs"
  add_foreign_key "user_program_attendances", "users"
end
