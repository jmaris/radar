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

ActiveRecord::Schema.define(version: 20160209160231) do

  create_table "alerts", force: :cascade do |t|
    t.string   "machine_id"
    t.string   "addressee"
    t.integer  "check_interval"
    t.float    "cpu_threshold"
    t.float    "ram_threshold"
    t.float    "swap_threshold"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "cpu_metrics", force: :cascade do |t|
    t.integer  "machine_id"
    t.float    "cpu"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "machines", force: :cascade do |t|
    t.string   "alias"
    t.string   "protocol"
    t.string   "host"
    t.integer  "port"
    t.integer  "update_interval"
    t.string   "hostname"
    t.string   "os"
    t.string   "cpu_model"
    t.integer  "cpu_cores"
    t.string   "cpu_architecture"
    t.integer  "ram_total_bytes",     limit: 16
    t.integer  "storage_total_bytes", limit: 16
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "ram_metrics", force: :cascade do |t|
    t.integer  "machine_id"
    t.float    "ram"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
