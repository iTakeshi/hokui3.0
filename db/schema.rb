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

ActiveRecord::Schema.define(version: 20130323123308) do

  create_table "semesters", force: true do |t|
    t.integer  "year_id",    null: false
    t.string   "identifier", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "semesters", ["year_id"], name: "index_semesters_on_year_id"

  create_table "years", force: true do |t|
    t.integer  "class_year", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "years", ["class_year"], name: "index_years_on_class_year", unique: true

end
