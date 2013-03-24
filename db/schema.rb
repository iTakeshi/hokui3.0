# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130324013929) do

  create_table "semesters", force: true do |t|
    t.integer  "year_id",    null: false
    t.string   "identifier", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "semesters", ["year_id"], name: "index_semesters_on_year_id"

  create_table "semesters_subjects", force: true do |t|
    t.integer "semester_id", null: false
    t.integer "subject_id",  null: false
  end

  add_index "semesters_subjects", ["semester_id"], name: "index_semesters_subjects_on_semester_id"
  add_index "semesters_subjects", ["subject_id"], name: "index_semesters_subjects_on_subject_id"

  create_table "subjects", force: true do |t|
    t.string   "title_en",   null: false
    t.string   "title_ja",   null: false
    t.string   "staff_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["title_en"], name: "index_subjects_on_title_en", unique: true
  add_index "subjects", ["title_ja"], name: "index_subjects_on_title_ja", unique: true

  create_table "users", force: true do |t|
    t.string   "family_name",                               null: false
    t.string   "given_name",                                null: false
    t.string   "handle_name",                               null: false
    t.date     "birthday",                                  null: false
    t.string   "email_official",                            null: false
    t.string   "email_private"
    t.integer  "year_id",                                   null: false
    t.boolean  "is_admin",                  default: false, null: false
    t.integer  "status",                                    null: false
    t.string   "auth_token",                                null: false
    t.string   "secret_token"
    t.string   "secret_token_generated_at"
    t.string   "password_digest",                           null: false
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email_official"], name: "index_users_on_email_official", unique: true
  add_index "users", ["handle_name"], name: "index_users_on_handle_name", unique: true

  create_table "years", force: true do |t|
    t.integer  "class_year", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "years", ["class_year"], name: "index_years_on_class_year", unique: true

end
