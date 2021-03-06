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

ActiveRecord::Schema.define(version: 20150821132344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "commit_fixes", force: true do |t|
    t.integer  "fixing_commit_id"
    t.integer  "fixed_commit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fixed_mongo_id"
    t.string   "fixes_mongo_id",   limit: 100
  end

  add_index "commit_fixes", ["fixed_commit_id"], name: "index_commit_fixes_on_fixed_commit_id", using: :btree
  add_index "commit_fixes", ["fixing_commit_id", "fixed_commit_id"], name: "index_commit_fixes_on_fixing_commit_id_and_fixed_commit_id", unique: true, using: :btree
  add_index "commit_fixes", ["fixing_commit_id"], name: "index_commit_fixes_on_fixing_commit_id", using: :btree

  create_table "commits", force: true do |t|
    t.string   "remote_id"
    t.text     "message"
    t.string   "url"
    t.string   "state"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "passed_at"
    t.integer  "author_id"
    t.datetime "expires_at"
    t.datetime "authored_at"
    t.integer  "reviewer_id"
  end

  add_index "commits", ["author_id"], name: "index_commits_on_author_id", using: :btree
  add_index "commits", ["project_id"], name: "index_commits_on_project_id", using: :btree
  add_index "commits", ["reviewer_id"], name: "index_commits_on_reviewer_id", using: :btree

  create_table "commits_tickets", id: false, force: true do |t|
    t.integer "commit_id"
    t.integer "ticket_id"
  end

  add_index "commits_tickets", ["commit_id", "ticket_id"], name: "index_commits_tickets_on_commit_id_and_ticket_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "invitations", force: true do |t|
    t.string   "email"
    t.string   "token"
    t.string   "role"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted",     default: false
    t.text     "project_ids",  default: [],    array: true
  end

  create_table "people", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_owners", force: true do |t|
    t.string   "name",       null: false
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string  "name"
    t.string  "url",              default: ""
    t.integer "trade_details",    default: 0,  null: false
    t.integer "project_owner_id"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tickets", force: true do |t|
    t.string "remote_id"
    t.string "url"
    t.string "source"
  end

  create_table "tokens", force: true do |t|
    t.string  "value"
    t.string  "tokenable_type"
    t.integer "tokenable_id"
  end

  add_index "tokens", ["tokenable_id", "tokenable_type"], name: "index_tokens_on_tokenable_id_and_tokenable_type", unique: true, using: :btree
  add_index "tokens", ["value"], name: "index_tokens_on_value", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string  "nickname"
    t.string  "email"
    t.string  "name"
    t.string  "image_url"
    t.string  "remote_uid"
    t.string  "provider"
    t.integer "person_id"
  end

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
