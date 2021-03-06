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

ActiveRecord::Schema.define(version: 20150804195707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advise_level_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "affected_areas", force: true do |t|
    t.integer  "patient_request_id"
    t.integer  "personal_area_type_id"
    t.string   "other_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "affected_areas", ["patient_request_id"], name: "index_affected_areas_on_patient_request_id", using: :btree
  add_index "affected_areas", ["personal_area_type_id"], name: "index_affected_areas_on_personal_area_type_id", using: :btree

  create_table "aid_level_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointments", force: true do |t|
    t.integer  "number"
    t.datetime "date"
    t.boolean  "attended"
    t.text     "notes"
    t.integer  "patient_record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appointments", ["patient_record_id"], name: "index_appointments_on_patient_record_id", using: :btree

  create_table "branch_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branches", force: true do |t|
    t.string   "name"
    t.integer  "branch_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "branches", ["branch_type_id"], name: "index_branches_on_branch_type_id", using: :btree

  create_table "careers", force: true do |t|
    t.string   "name"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "careers", ["branch_id"], name: "index_careers_on_branch_id", using: :btree

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

  create_table "condition_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experience_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experience_types_patient_records", id: false, force: true do |t|
    t.integer "experience_type_id"
    t.integer "patient_record_id"
  end

  add_index "experience_types_patient_records", ["experience_type_id"], name: "index_experience_types_patient_records_on_experience_type_id", using: :btree
  add_index "experience_types_patient_records", ["patient_record_id"], name: "index_experience_types_patient_records_on_patient_record_id", using: :btree

  create_table "how_met_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "how_mets", force: true do |t|
    t.integer  "patient_request_id"
    t.integer  "how_met_type_id"
    t.string   "other_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "how_mets", ["how_met_type_id"], name: "index_how_mets_on_how_met_type_id", using: :btree
  add_index "how_mets", ["patient_request_id"], name: "index_how_mets_on_patient_request_id", using: :btree

  create_table "improve_areas", force: true do |t|
    t.integer  "patient_signout_id"
    t.integer  "personal_area_type_id"
    t.string   "other_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "improve_areas", ["patient_signout_id"], name: "index_improve_areas_on_patient_signout_id", using: :btree
  add_index "improve_areas", ["personal_area_type_id"], name: "index_improve_areas_on_personal_area_type_id", using: :btree

  create_table "mechanism_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mechanism_types_patient_records", id: false, force: true do |t|
    t.integer "mechanism_type_id"
    t.integer "patient_record_id"
  end

  add_index "mechanism_types_patient_records", ["mechanism_type_id"], name: "index_mechanism_types_patient_records_on_mechanism_type_id", using: :btree
  add_index "mechanism_types_patient_records", ["patient_record_id"], name: "index_mechanism_types_patient_records_on_patient_record_id", using: :btree

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

  add_index "paternal_traits", ["paternal_trait_type_id"], name: "index_paternal_traits_on_paternal_trait_type_id", using: :btree
  add_index "paternal_traits", ["patient_record_id"], name: "index_paternal_traits_on_patient_record_id", using: :btree

  create_table "patient_channelizations", force: true do |t|
    t.string   "where"
    t.integer  "patient_dropout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patient_channelizations", ["patient_dropout_id"], name: "index_patient_channelizations_on_patient_dropout_id", using: :btree

  create_table "patient_dropout_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_dropouts", force: true do |t|
    t.integer  "patient_dropout_type_id"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patient_dropouts", ["patient_dropout_type_id"], name: "index_patient_dropouts_on_patient_dropout_type_id", using: :btree
  add_index "patient_dropouts", ["patient_id"], name: "index_patient_dropouts_on_patient_id", using: :btree

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

  add_index "patient_records", ["cie10_type_id"], name: "index_patient_records_on_cie10_type_id", using: :btree
  add_index "patient_records", ["clinical_structure_type_id"], name: "index_patient_records_on_clinical_structure_type_id", using: :btree
  add_index "patient_records", ["patient_id"], name: "index_patient_records_on_patient_id", using: :btree
  add_index "patient_records", ["therapist_id"], name: "index_patient_records_on_therapist_id", using: :btree

  create_table "patient_requests", force: true do |t|
    t.float    "money"
    t.boolean  "pre_care"
    t.date     "request_date"
    t.date     "attention_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "receive_therapist_id"
    t.integer  "patient_id"
    t.integer  "contact_therapist_id"
    t.integer  "condition_type_id"
  end

  add_index "patient_requests", ["patient_id"], name: "index_patient_requests_on_patient_id", using: :btree

  create_table "patient_signouts", force: true do |t|
    t.integer  "condition_type_id"
    t.integer  "rating"
    t.text     "satisfactions"
    t.text     "claims"
    t.text     "observations"
    t.integer  "patient_dropout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "aid_level_type_id"
    t.integer  "advise_level_type_id"
  end

  add_index "patient_signouts", ["advise_level_type_id"], name: "index_patient_signouts_on_advise_level_type_id", using: :btree
  add_index "patient_signouts", ["aid_level_type_id"], name: "index_patient_signouts_on_aid_level_type_id", using: :btree
  add_index "patient_signouts", ["condition_type_id"], name: "index_patient_signouts_on_condition_type_id", using: :btree
  add_index "patient_signouts", ["patient_dropout_id"], name: "index_patient_signouts_on_patient_dropout_id", using: :btree

  create_table "patient_status_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: true do |t|
    t.string   "p_last_name"
    t.string   "m_last_name"
    t.string   "names"
    t.integer  "account_number"
    t.date     "birth"
    t.string   "sex"
    t.string   "init_school"
    t.integer  "semester"
    t.integer  "failed_subjects"
    t.string   "telephone1"
    t.string   "telephone2"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "patient_status_type_id"
    t.integer  "career_id"
  end

  add_index "patients", ["career_id"], name: "index_patients_on_career_id", using: :btree
  add_index "patients", ["patient_status_type_id"], name: "index_patients_on_patient_status_type_id", using: :btree

  create_table "personal_area_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reasons", force: true do |t|
    t.string   "other_name"
    t.integer  "patient_request_id"
    t.integer  "reasons_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reasons", ["patient_request_id"], name: "index_reasons_on_patient_request_id", using: :btree
  add_index "reasons", ["reasons_type_id"], name: "index_reasons_on_reasons_type_id", using: :btree

  create_table "reasons_types", force: true do |t|
    t.string   "name"
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

  add_index "request_schedules", ["patient_request_id"], name: "index_request_schedules_on_patient_request_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

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

  add_index "symptoms", ["appointment_id"], name: "index_symptoms_on_appointment_id", using: :btree
  add_index "symptoms", ["symptom_type_id"], name: "index_symptoms_on_symptom_type_id", using: :btree

  create_table "therapist_schedules", force: true do |t|
    t.integer  "day"
    t.time     "beginH"
    t.time     "endH"
    t.integer  "therapist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "therapist_schedules", ["therapist_id"], name: "index_therapist_schedules_on_therapist_id", using: :btree

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
    t.string   "telephone1"
    t.string   "telephone2"
    t.string   "p_last_name"
    t.string   "m_last_name"
    t.string   "names"
    t.integer  "branch_id"
  end

  add_index "therapists", ["branch_id"], name: "index_therapists_on_branch_id", using: :btree
  add_index "therapists", ["email"], name: "index_therapists_on_email", unique: true, using: :btree
  add_index "therapists", ["reset_password_token"], name: "index_therapists_on_reset_password_token", unique: true, using: :btree

  create_table "therapists_roles", id: false, force: true do |t|
    t.integer "therapist_id"
    t.integer "role_id"
  end

  add_index "therapists_roles", ["therapist_id", "role_id"], name: "index_therapists_roles_on_therapist_id_and_role_id", using: :btree

end
