# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_30_065623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.string "code", null: false
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["code"], name: "index_devices_on_code", unique: true
  end

  create_table "logs", force: :cascade do |t|
    t.string "ip_address"
    t.string "params"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "fullname"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["remember_digest"], name: "index_users_on_remember_digest"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
