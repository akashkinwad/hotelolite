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

ActiveRecord::Schema.define(version: 2020_02_23_050950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "api_calls", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_api_calls_on_user_id"
  end

  create_table "api_tokens", force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_api_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_api_tokens_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "contact_no"
    t.string "altr_contact_no"
    t.string "email", default: "", null: false
    t.datetime "check_in"
    t.bigint "farm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["farm_id"], name: "index_bookings_on_farm_id"
  end

  create_table "farms", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "contact_no"
    t.string "altr_contact_no"
    t.string "district"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_farms_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "title"
    t.integer "provider_id"
    t.bigint "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "response"
    t.string "info"
    t.bigint "user_id"
    t.bigint "subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_orders_on_subscription_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payment_details", force: :cascade do |t|
    t.string "cashholders_name"
    t.string "card_number"
    t.string "expiry_date"
    t.string "cvv"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "zipcode"
    t.string "country"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["user_id"], name: "index_payment_details_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.text "features"
    t.decimal "price_per_month"
    t.decimal "price_per_year"
    t.integer "calls_limit_per_hour"
    t.boolean "active"
    t.integer "sports_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "allow_all_tournaments", default: false
    t.boolean "is_available_monthly"
    t.boolean "is_available_annually"
    t.integer "free_trial_days"
    t.integer "usage", default: 0
  end

  create_table "plans_tournaments", id: false, force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "tournament_id", null: false
    t.index ["plan_id", "tournament_id"], name: "index_plans_tournaments_on_plan_id_and_tournament_id"
    t.index ["tournament_id", "plan_id"], name: "index_plans_tournaments_on_tournament_id_and_plan_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recent_activities", force: :cascade do |t|
    t.string "description"
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_recent_activities_on_resource_id"
    t.index ["resource_type"], name: "index_recent_activities_on_resource_type"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.bigint "farm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["farm_id"], name: "index_sections_on_farm_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_sections", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_sub_sections_on_section_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.boolean "has_trial"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "s_type"
    t.boolean "active", default: true
    t.boolean "auto_renewal", default: false
    t.bigint "user_id"
    t.bigint "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "resource_id"
    t.string "resource_type"
    t.decimal "price_per_month"
    t.decimal "price_per_year"
    t.decimal "calls_limit_per_hour"
    t.string "sports_type"
    t.string "payment_method"
    t.string "stripe_email"
    t.string "stripe_token"
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["resource_id"], name: "index_subscriptions_on_resource_id"
    t.index ["resource_type"], name: "index_subscriptions_on_resource_type"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.integer "provider_tournament_id"
    t.integer "status", default: 0
    t.bigint "provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_tournaments_on_provider_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "api_calls", "users"
  add_foreign_key "api_tokens", "users"
  add_foreign_key "bookings", "farms"
  add_foreign_key "farms", "users"
  add_foreign_key "matches", "tournaments"
  add_foreign_key "orders", "subscriptions"
  add_foreign_key "orders", "users"
  add_foreign_key "payment_details", "users"
  add_foreign_key "sections", "farms"
  add_foreign_key "sub_sections", "sections"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "tournaments", "providers"
end
