# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_11_20_172931) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "api_clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "api_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key"], name: "index_api_clients_on_api_key", unique: true
  end

  create_table "api_keys", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "key", null: false
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_api_keys_on_client_id"
    t.index ["key"], name: "index_api_keys_on_key", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "markup_percentage", default: "30.0", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_clients_on_name", unique: true
  end

  create_table "credit_balances", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.decimal "amount", null: false
    t.string "description"
    t.datetime "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_credit_balances_on_client_id"
  end

  create_table "identity_verifications", primary_key: "id_number", id: :string, force: :cascade do |t|
    t.string "firstnames"
    t.string "lastname"
    t.date "dob"
    t.integer "age"
    t.string "gender"
    t.string "citizenship"
    t.datetime "date_issued"
    t.string "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "verification_data"
    t.datetime "verified_at"
    t.index ["verified_at"], name: "index_identity_verifications_on_verified_at"
  end

  create_table "licence_verifications", force: :cascade do |t|
    t.datetime "date_of_birth"
    t.string "document_number"
    t.string "document_type"
    t.string "first_names"
    t.string "full_name"
    t.string "gender"
    t.string "initials"
    t.string "issue_country"
    t.string "issue_place"
    t.string "last_name"
    t.string "middle_names"
    t.string "person_identification_number"
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.integer "drivers_license_type"
    t.integer "issue_number"
    t.string "permit_categories"
    t.datetime "permit_valid_to"
    t.string "restrictions"
    t.json "vehicle_code"
    t.json "vehicle_first_issue"
    t.json "vehicle_restriction"
    t.text "photo_jpg"
    t.string "id_verification_status"
    t.string "id_verification_firstnames"
    t.string "id_verification_lastname"
    t.string "id_verification_dob"
    t.integer "id_verification_age"
    t.string "id_verification_gender"
    t.string "id_verification_citizenship"
    t.datetime "id_verification_date_issued"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "price_overrides", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "service_type", null: false
    t.decimal "markup_percentage", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "service_type"], name: "index_price_overrides_on_client_id_and_service_type", unique: true
    t.index ["client_id"], name: "index_price_overrides_on_client_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "service_type", null: false
    t.decimal "base_amount", null: false
    t.decimal "charged_amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_transactions_on_client_id"
  end

  add_foreign_key "api_keys", "clients"
  add_foreign_key "credit_balances", "clients"
  add_foreign_key "price_overrides", "clients"
  add_foreign_key "transactions", "clients"
end
