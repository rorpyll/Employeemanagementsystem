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

ActiveRecord::Schema.define(version: 2022_05_30_084408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "attendences", force: :cascade do |t|
    t.datetime "checkin_time"
    t.datetime "checkout_time"
    t.string "status"
    t.string "hour"
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "checkin_ip_address"
    t.string "checkout_ip_address"
    t.index ["employee_id"], name: "index_attendences_on_employee_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "daily_tasks", force: :cascade do |t|
    t.text "description"
    t.integer "rank", default: 10
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_daily_tasks_on_employee_id"
  end

  create_table "designations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "father_name"
    t.string "mother_name"
    t.string "phone_number"
    t.text "address"
    t.integer "trainer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "image"
    t.integer "leave_count", default: 1
    t.string "department"
    t.string "bank_name"
    t.string "account_number"
    t.string "pan_card_number"
    t.string "aadhar_card_number"
    t.integer "salary"
    t.text "primary_skill"
    t.date "date_of_birth"
    t.bigint "designation_id"
    t.bigint "role_id"
    t.date "joining_date"
    t.string "gender"
    t.index ["designation_id"], name: "index_employees_on_designation_id"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_employees_on_role_id"
  end

  create_table "holidays", force: :cascade do |t|
    t.string "holiday_name"
    t.date "holiday_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "holiday_type"
  end

  create_table "ips", force: :cascade do |t|
    t.string "unblockip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "leafs", force: :cascade do |t|
    t.string "leave_type"
    t.date "from_date"
    t.date "till_date"
    t.string "leave_starts"
    t.string "leave_end"
    t.float "total_days"
    t.string "resion"
    t.string "leave_status"
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_leafs_on_employee_id"
  end

  create_table "performances", force: :cascade do |t|
    t.integer "points"
    t.string "month"
    t.date "from"
    t.date "to"
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_performances_on_employee_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "salaries", force: :cascade do |t|
    t.integer "salary"
    t.string "month"
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "leaves"
    t.integer "earnings"
    t.integer "deductions"
    t.integer "total_working_days"
    t.index ["employee_id"], name: "index_salaries_on_employee_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "status"
    t.text "description"
    t.string "ticket_type"
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "updated_by"
    t.string "reason"
    t.index ["employee_id"], name: "index_tickets_on_employee_id"
  end

  add_foreign_key "attendences", "employees"
  add_foreign_key "daily_tasks", "employees"
  add_foreign_key "employees", "designations"
  add_foreign_key "employees", "roles"
  add_foreign_key "leafs", "employees"
  add_foreign_key "performances", "employees"
  add_foreign_key "salaries", "employees"
  add_foreign_key "tickets", "employees"
end
