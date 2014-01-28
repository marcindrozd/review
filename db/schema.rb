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

ActiveRecord::Schema.define(version: 20140123143108) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commits", force: true do |t|
    t.string  "remote_id"
    t.string  "message"
    t.string  "url"
    t.string  "state"
    t.integer "project_id"
  end

  add_index "commits", ["project_id"], name: "index_commits_on_project_id", using: :btree

  create_table "commits_tickets", id: false, force: true do |t|
    t.integer "commit_id"
    t.integer "ticket_id"
  end

  add_index "commits_tickets", ["commit_id", "ticket_id"], name: "index_commits_tickets_on_commit_id_and_ticket_id", using: :btree

  create_table "permissions", force: true do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.boolean "allowed",    default: false
  end

  add_index "permissions", ["project_id", "user_id"], name: "index_permissions_on_project_id_and_user_id", unique: true, using: :btree
  add_index "permissions", ["project_id"], name: "index_permissions_on_project_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string "name"
  end

  create_table "tickets", force: true do |t|
    t.string "remote_id"
    t.string "url"
    t.string "source"
  end

  create_table "users", force: true do |t|
    t.string  "nickname"
    t.string  "email"
    t.string  "name"
    t.string  "image_url"
    t.string  "remote_uid"
    t.string  "provider"
    t.boolean "admin",      default: false
  end

end
