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

ActiveRecord::Schema.define(version: 2019_08_26_102240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.bigint "area_id"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["area_id"], name: "index_devices_on_area_id"
    t.index ["name", "position", "area_id"], name: "index_devices_on_name_and_position_and_area_id", unique: true
  end

  create_table "devices_groups", force: :cascade do |t|
    t.bigint "device_id", null: false
    t.bigint "group_id", null: false
    t.index ["device_id"], name: "index_devices_groups_on_device_id"
    t.index ["group_id"], name: "index_devices_groups_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
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

  add_foreign_key "devices", "areas"
  add_foreign_key "devices_groups", "devices"
  add_foreign_key "devices_groups", "groups"
end
