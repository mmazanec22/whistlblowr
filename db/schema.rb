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

ActiveRecord::Schema.define(version: 20160906233149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allegation_types", force: :cascade do |t|
    t.string   "allegation_nature", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "allegations", force: :cascade do |t|
    t.integer  "complaint_id"
    t.integer  "allegation_type_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["allegation_type_id"], name: "index_allegations_on_allegation_type_id", using: :btree
    t.index ["complaint_id"], name: "index_allegations_on_complaint_id", using: :btree
  end

  create_table "complaints", force: :cascade do |t|
    t.string   "key",                         null: false
    t.integer  "user_id"
    t.text     "content",                     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.json     "media"
    t.string   "status",      default: "New"
    t.string   "video_links"
    t.index ["user_id"], name: "index_complaints_on_user_id", using: :btree
  end

  create_table "investigators", force: :cascade do |t|
    t.string   "username",                               null: false
    t.string   "email",                                  null: false
    t.string   "encrypted_password",                     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_investigators_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_investigators_on_reset_password_token", unique: true, using: :btree
  end

  create_table "media", force: :cascade do |t|
    t.integer  "complaint_id"
    t.string   "media_type",   null: false
    t.string   "url",          null: false
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["complaint_id"], name: "index_media_on_complaint_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "text"
    t.integer  "complaint_id"
    t.integer  "messageable_id"
    t.string   "messageable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "allegations", "allegation_types"
  add_foreign_key "allegations", "complaints"
  add_foreign_key "complaints", "users"
  add_foreign_key "media", "complaints"
end
