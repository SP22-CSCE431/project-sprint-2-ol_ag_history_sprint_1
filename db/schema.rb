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

ActiveRecord::Schema.define(version: 2022_03_04_202529) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "attendances", force: :cascade do |t|
    t.integer "member_id"
    t.integer "event_id"
    t.boolean "attended"
    t.boolean "rsvp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dues", force: :cascade do |t|
    t.integer "member_id"
    t.integer "event_id"
    t.integer "dueAmount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "paid"
  end

  create_table "events", force: :cascade do |t|
    t.integer "eventID"
    t.string "name"
    t.string "location"
    t.string "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "description"
    t.string "RSVP"
  end

  create_table "lineages", force: :cascade do |t|
    t.integer "member_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "father"
    t.integer "son"
  end

  create_table "members", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.date "joinDate"
    t.string "email"
    t.string "phoneNumber"
    t.string "city"
    t.boolean "admin"
    t.string "major"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active"
    t.date "gradDate"
  end

end
