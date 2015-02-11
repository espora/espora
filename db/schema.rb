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

ActiveRecord::Schema.define(version: 20150211183016) do

  create_table "affected_areas", force: true do |t|
    t.string   "area"
    t.integer  "patient_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "affected_areas", ["patient_request_id"], name: "index_affected_areas_on_patient_request_id"

  create_table "appointments", force: true do |t|
    t.integer  "number"
    t.datetime "date"
    t.boolean  "attended"
    t.text     "notes"
    t.integer  "patient_record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appointments", ["patient_record_id"], name: "index_appointments_on_patient_record_id"

  create_table "cie10_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clinical_structure_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experience_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mechanism_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paternal_trait_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paternal_traits", force: true do |t|
    t.boolean  "from_mother"
    t.integer  "patient_record_id"
    t.integer  "paternal_trait_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "paternal_traits", ["paternal_trait_type_id"], name: "index_paternal_traits_on_paternal_trait_type_id"
  add_index "paternal_traits", ["patient_record_id"], name: "index_paternal_traits_on_patient_record_id"

  create_table "patient_records", force: true do |t|
    t.text     "observations"
    t.text     "lives_with"
    t.integer  "patient_id"
    t.integer  "therapist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cie10_type_id"
    t.integer  "clinical_structure_type_id"
  end

  add_index "patient_records", ["cie10_type_id"], name: "index_patient_records_on_cie10_type_id"
  add_index "patient_records", ["clinical_structure_type_id"], name: "index_patient_records_on_clinical_structure_type_id"
  add_index "patient_records", ["patient_id"], name: "index_patient_records_on_patient_id"
  add_index "patient_records", ["therapist_id"], name: "index_patient_records_on_therapist_id"

  create_table "patient_records_experience_types", id: false, force: true do |t|
    t.integer "patient_record_id"
    t.integer "experience_type_id"
  end

  add_index "patient_records_experience_types", ["experience_type_id"], name: "index_patient_records_experience_types_on_experience_type_id"
  add_index "patient_records_experience_types", ["patient_record_id"], name: "index_patient_records_experience_types_on_patient_record_id"

  create_table "patient_records_mechanism_types", id: false, force: true do |t|
    t.integer "patient_record_id"
    t.integer "mechanism_type_id"
  end

  add_index "patient_records_mechanism_types", ["mechanism_type_id"], name: "index_patient_records_mechanism_types_on_mechanism_type_id"
  add_index "patient_records_mechanism_types", ["patient_record_id"], name: "index_patient_records_mechanism_types_on_patient_record_id"

  create_table "patient_requests", force: true do |t|
    t.text     "reasons"
    t.string   "condition"
    t.string   "how_met"
    t.float    "money"
    t.boolean  "pre_care"
    t.date     "request_date"
    t.date     "attention_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "receive_therapist_id"
    t.integer  "patient_id"
    t.integer  "contact_therapist_id"
  end

  add_index "patient_requests", ["patient_id"], name: "index_patient_requests_on_patient_id"

  create_table "patients", force: true do |t|
    t.string   "p_last_name"
    t.string   "m_last_name"
    t.string   "names"
    t.integer  "account_number"
    t.date     "birth"
    t.integer  "age"
    t.string   "sex"
    t.string   "career"
    t.string   "init_school"
    t.integer  "semester"
    t.integer  "failed_subjects"
    t.string   "telephone1"
    t.string   "telephone2"
    t.string   "email"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_schedules", force: true do |t|
    t.integer  "day"
    t.time     "beginH"
    t.time     "endH"
    t.integer  "patient_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "request_schedules", ["patient_request_id"], name: "index_request_schedules_on_patient_request_id"

  create_table "symptom_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "symptoms", force: true do |t|
    t.integer  "symptom_type_id"
    t.integer  "level"
    t.integer  "appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "symptoms", ["appointment_id"], name: "index_symptoms_on_appointment_id"
  add_index "symptoms", ["symptom_type_id"], name: "index_symptoms_on_symptom_type_id"

  create_table "therapist_schedules", force: true do |t|
    t.integer  "day"
    t.time     "beginH"
    t.time     "endH"
    t.integer  "therapist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "therapist_schedules", ["therapist_id"], name: "index_therapist_schedules_on_therapist_id"

  create_table "therapists", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scholar_grade"
    t.string   "role"
    t.string   "telephone1"
    t.string   "telephone2"
    t.string   "p_last_name"
    t.string   "m_last_name"
    t.string   "names"
  end

  add_index "therapists", ["email"], name: "index_therapists_on_email", unique: true
  add_index "therapists", ["reset_password_token"], name: "index_therapists_on_reset_password_token", unique: true

end
