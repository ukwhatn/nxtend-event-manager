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

ActiveRecord::Schema[7.2].define(version: 2024_09_03_094856) do
  create_table "event_pragrams", force: :cascade do |t|
    t.integer "event_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_pragrams_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "description", null: false
    t.datetime "location", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.datetime "is_cancelled", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kc32024_stamp_collects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "kc32024_stamp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kc32024_stamp_id"], name: "index_kc32024_stamp_collects_on_kc32024_stamp_id"
    t.index ["user_id"], name: "index_kc32024_stamp_collects_on_user_id"
  end

  create_table "kc32024_stamps", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_event_attendances", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
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
  end

  create_table "user_program_attendances", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_program_id", null: false
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
  end

  add_foreign_key "event_pragrams", "events"
  add_foreign_key "kc32024_stamp_collects", "kc32024_stamps"
  add_foreign_key "kc32024_stamp_collects", "users"
  add_foreign_key "user_event_attendances", "events"
  add_foreign_key "user_event_attendances", "users"
  add_foreign_key "user_program_attendances", "event_programs"
  add_foreign_key "user_program_attendances", "users"
end
