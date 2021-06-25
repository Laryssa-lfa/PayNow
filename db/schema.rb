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

ActiveRecord::Schema.define(version: 2021_06_24_195940) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "occupation"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "boletos", force: :cascade do |t|
    t.decimal "rate"
    t.integer "bank_code"
    t.integer "bank_agency"
    t.integer "bank_account"
    t.boolean "status", default: false, null: false
    t.integer "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_boletos_on_admin_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "card_name"
    t.string "code"
    t.decimal "rate"
    t.boolean "status", default: false, null: false
    t.integer "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_cards_on_admin_id"
  end

  create_table "change_history_to_companies", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "cnpj"
    t.string "corporate_name"
    t.string "address"
    t.string "email"
    t.string "token"
    t.integer "client_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_change_history_to_companies_on_company_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.integer "cnpj"
    t.string "corporate_name"
    t.string "address"
    t.string "email"
    t.string "token"
    t.integer "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "status", default: false, null: false
    t.index ["client_id"], name: "index_companies_on_client_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "boleto_id", null: false
    t.integer "card_id", null: false
    t.integer "pix_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["boleto_id"], name: "index_payment_methods_on_boleto_id"
    t.index ["card_id"], name: "index_payment_methods_on_card_id"
    t.index ["company_id"], name: "index_payment_methods_on_company_id"
    t.index ["pix_id"], name: "index_payment_methods_on_pix_id"
  end

  create_table "pixes", force: :cascade do |t|
    t.decimal "rate"
    t.string "code"
    t.integer "bank_code"
    t.boolean "status", default: false, null: false
    t.integer "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_pixes_on_admin_id"
  end

  add_foreign_key "boletos", "admins"
  add_foreign_key "cards", "admins"
  add_foreign_key "change_history_to_companies", "companies"
  add_foreign_key "companies", "clients"
  add_foreign_key "payment_methods", "boletos"
  add_foreign_key "payment_methods", "cards"
  add_foreign_key "payment_methods", "companies"
  add_foreign_key "payment_methods", "pixes"
  add_foreign_key "pixes", "admins"
end
