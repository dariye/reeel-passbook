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

ActiveRecord::Schema.define(version: 20150710062003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "screenings", force: :cascade do |t|
    t.string   "title",                   default: ""
    t.string   "location",                default: ""
    t.datetime "time_date",               default: '2015-07-10 06:16:10'
    t.integer  "valid_for",               default: 0
    t.text     "terms_n_conditions",      default: ""
    t.string   "pass_barcode_string",     default: ""
    t.integer  "pass_id"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "bg_img_file_name"
    t.string   "bg_img_content_type"
    t.integer  "bg_img_file_size"
    t.datetime "bg_img_updated_at"
    t.string   "bg_img_x_file_name"
    t.string   "bg_img_x_content_type"
    t.integer  "bg_img_x_file_size"
    t.datetime "bg_img_x_updated_at"
    t.string   "icon_img_file_name"
    t.string   "icon_img_content_type"
    t.integer  "icon_img_file_size"
    t.datetime "icon_img_updated_at"
    t.string   "icon_img_x_file_name"
    t.string   "icon_img_x_content_type"
    t.integer  "icon_img_x_file_size"
    t.datetime "icon_img_x_updated_at"
    t.string   "logo_img_file_name"
    t.string   "logo_img_content_type"
    t.integer  "logo_img_file_size"
    t.datetime "logo_img_updated_at"
    t.string   "logo_img_x_file_name"
    t.string   "logo_img_x_content_type"
    t.integer  "logo_img_x_file_size"
    t.datetime "logo_img_x_updated_at"
    t.string   "tn_img_file_name"
    t.string   "tn_img_content_type"
    t.integer  "tn_img_file_size"
    t.datetime "tn_img_updated_at"
    t.string   "tn_img_x_file_name"
    t.string   "tn_img_x_content_type"
    t.integer  "tn_img_x_file_size"
    t.datetime "tn_img_x_updated_at"
  end

  add_index "screenings", ["pass_id"], name: "index_screenings_on_pass_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
