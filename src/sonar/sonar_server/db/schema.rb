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

ActiveRecord::Schema.define(version: 20160405114821) do

  create_table "alerts", force: :cascade do |t|
    t.integer  "machine_id"
    t.string   "addressee"
    t.integer  "check_interval"
    t.string   "custom_message"
    t.boolean  "triggered"
    t.integer  "actable_id"
    t.string   "actable_type"
    t.integer  "delayed_job_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "cpu_alerts", force: :cascade do |t|
    t.float    "threshold"
    t.integer  "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cpu_metrics", force: :cascade do |t|
    t.integer  "machine_id"
    t.float    "cpu"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cpu_metrics", ["machine_id"], name: "index_cpu_metrics_on_machine_id"

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

  create_table "log_alerts", force: :cascade do |t|
    t.string   "logger_type"
    t.string   "path"
    t.string   "arguments"
    t.integer  "match_amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "machines", force: :cascade do |t|
    t.string   "alias"
    t.string   "protocol"
    t.string   "host"
    t.integer  "port"
    t.integer  "update_interval"
    t.integer  "delayed_job_id"
    t.string   "hostname"
    t.string   "os"
    t.string   "cpu_model"
    t.integer  "cpu_cores"
    t.string   "cpu_architecture"
    t.integer  "ram_total_bytes",     limit: 8
    t.integer  "storage_total_bytes", limit: 8
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "ram_alerts", force: :cascade do |t|
    t.float    "threshold"
    t.integer  "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ram_metrics", force: :cascade do |t|
    t.integer  "machine_id"
    t.float    "ram"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ram_metrics", ["machine_id"], name: "index_ram_metrics_on_machine_id"

  create_table "storage_alerts", force: :cascade do |t|
    t.float    "threshold"
    t.string   "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "storage_metrics", force: :cascade do |t|
    t.integer  "machine_id"
    t.float    "storage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "storage_metrics", ["machine_id"], name: "index_storage_metrics_on_machine_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
