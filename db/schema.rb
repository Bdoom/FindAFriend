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

ActiveRecord::Schema.define(version: 2019_08_07_175021) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activity_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_groups_on_activity_id"
    t.index ["user_id"], name: "index_activity_groups_on_user_id"
  end

  create_table "ip_address_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "ip_address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip_address_id"], name: "index_ip_address_groups_on_ip_address_id"
    t.index ["user_id"], name: "index_ip_address_groups_on_user_id"
  end

  create_table "ip_addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.string "country"
    t.string "address"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zipcode"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "about_me"
    t.bigint "ip_address_id"
    t.bigint "location_id"
    t.string "gender"
    t.string "sexuality"
    t.string "religion"
    t.string "race"
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["ip_address_id"], name: "index_users_on_ip_address_id"
    t.index ["location_id"], name: "index_users_on_location_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "locations", "users"
  add_foreign_key "users", "ip_addresses"
  add_foreign_key "users", "locations", on_delete: :cascade
end
