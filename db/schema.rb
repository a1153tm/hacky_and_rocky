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

ActiveRecord::Schema.define(version: 20131021110748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "publisher"
    t.string   "isbn"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item_code"
    t.integer  "item_price"
    t.text     "item_caption"
    t.string   "item_url"
    t.string   "sales_date"
    t.string   "small_image_url"
    t.string   "medium_image_url"
    t.string   "large_image_url"
    t.string   "books_genre_id"
    t.integer  "genre_id"
  end

  create_table "dudas", force: true do |t|
    t.string   "dum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dummies", force: true do |t|
    t.string   "dummy"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dum2"
  end

  create_table "genres", force: true do |t|
    t.integer  "genre_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "race_grades", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "race_horse_points", force: true do |t|
    t.integer  "race_horse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "race_progress_id"
  end

  create_table "race_horses", force: true do |t|
    t.text     "comment"
    t.integer  "race_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "horse_no"
  end

  create_table "race_progresses", force: true do |t|
    t.date     "record_date"
    t.integer  "race_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", force: true do |t|
    t.string   "name"
    t.integer  "grade"
    t.string   "etype"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "genre_id"
  end

  create_table "ranking_points", force: true do |t|
    t.integer  "point"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "race_horse_point_id"
  end

  create_table "rankings", force: true do |t|
    t.text     "xml"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.integer  "point"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
  end

  create_table "vote_items", force: true do |t|
    t.integer  "point_weight"
    t.integer  "voting_card_id"
    t.integer  "race_horse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "voting_cards", force: true do |t|
    t.date     "vote_date"
    t.integer  "race_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
