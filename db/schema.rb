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

ActiveRecord::Schema.define(version: 20140123130754) do

  create_table "achievements", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "learner_id"
    t.integer  "tracker_id"
    t.text     "description"
    t.string   "asset"
    t.integer  "focus_id"
    t.datetime "trashed_at"
    t.integer  "subject_id"
  end

  create_table "foci", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foci", ["name"], name: "index_foci_on_name", unique: true, using: :btree

  create_table "focus_positions", force: true do |t|
    t.integer  "focus_id"
    t.integer  "learner_id"
    t.float    "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "focus_positions", ["focus_id"], name: "index_focus_positions_on_focus_id", using: :btree
  add_index "focus_positions", ["learner_id"], name: "index_focus_positions_on_learner_id", using: :btree

  create_table "focus_positions_updates", force: true do |t|
    t.integer  "learner_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "focus_positions_updates", ["learner_id"], name: "index_focus_positions_updates_on_learner_id", using: :btree

  create_table "learners", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "age"
    t.string   "class_year"
    t.text     "about_me"
    t.text     "about_me_as_a_learner"
    t.text     "hobbies_and_interests"
    t.text     "big_ambitions"
    t.text     "favourite_things"
    t.text     "best_thing_this_week"
    t.string   "avatar"
  end

  add_index "learners", ["email"], name: "index_learners_on_email", unique: true, using: :btree

  create_table "reports", force: true do |t|
    t.integer  "learner_id"
    t.text     "about_me"
    t.text     "where_i_started"
    t.text     "where_i_am_now"
    t.text     "where_i_want_to_be"
    t.text     "teacher_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reports", ["learner_id"], name: "index_reports_on_learner_id", using: :btree

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["name"], name: "index_subjects_on_name", unique: true, using: :btree

  create_table "trackers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "learner_id"
    t.datetime "trashed_at"
    t.text     "description"
    t.integer  "focus_id"
    t.string   "difficulty"
    t.integer  "subject_id"
  end

end
