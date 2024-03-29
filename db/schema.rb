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

ActiveRecord::Schema.define(version: 20140909130947) do

  create_table "nodes", force: true do |t|
    t.integer  "dropbox_id"
    t.string   "ancestry"
    t.string   "name"
    t.integer  "size",         limit: 8
    t.string   "filetype"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "dropbox_path"
  end

  add_index "nodes", ["ancestry", "name"], name: "index_nodes_on_ancestry_and_name", unique: true, using: :btree
  add_index "nodes", ["filetype"], name: "index_nodes_on_filetype", using: :btree

  create_table "users", id: false, force: true do |t|
    t.integer  "dropbox_id"
    t.string   "access_token"
    t.text     "account"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "last_cursor"
    t.boolean  "account_ready",   default: false
    t.datetime "last_checked_at"
  end

  add_index "users", ["dropbox_id"], name: "index_users_on_dropbox_id", unique: true, using: :btree

end
