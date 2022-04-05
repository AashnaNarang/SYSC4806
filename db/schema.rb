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

ActiveRecord::Schema[7.0].define(version: 2022_03_17_174955) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mc_options", force: :cascade do |t|
    t.string "option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mc_question_id"
    t.index ["mc_question_id"], name: "index_mc_options_on_mc_question_id"
  end

  create_table "mc_questions", force: :cascade do |t|
    t.text "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "survey_id"
    t.integer "order"
    t.index ["survey_id"], name: "index_mc_questions_on_survey_id"
  end

  create_table "mc_responses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mc_question_id"
    t.integer "mc_option_id"
    t.integer "survey_responder_id"
    t.index ["mc_option_id"], name: "index_mc_responses_on_mc_option_id"
    t.index ["mc_question_id"], name: "index_mc_responses_on_mc_question_id"
    t.index ["survey_responder_id"], name: "index_mc_responses_on_survey_responder_id"
  end

  create_table "survey_responders", force: :cascade do |t|
    t.time "respondedAt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "survey_id"
    t.index ["survey_id"], name: "index_survey_responders_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "title"
    t.boolean "isLive"
    t.datetime "wentLiveAt", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "closedOnDate", null: false
  end

  create_table "text_questions", force: :cascade do |t|
    t.text "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "survey_id"
    t.integer "order"
    t.index ["survey_id"], name: "index_text_questions_on_survey_id"
  end

  create_table "text_responses", force: :cascade do |t|
    t.text "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "text_question_id"
    t.integer "survey_responder_id"
    t.index ["survey_responder_id"], name: "index_text_responses_on_survey_responder_id"
    t.index ["text_question_id"], name: "index_text_responses_on_text_question_id"
  end

  add_foreign_key "mc_options", "mc_questions"
  add_foreign_key "mc_questions", "surveys"
  add_foreign_key "mc_responses", "mc_options"
  add_foreign_key "mc_responses", "mc_questions"
  add_foreign_key "mc_responses", "survey_responders"
  add_foreign_key "survey_responders", "surveys"
  add_foreign_key "text_questions", "surveys"
  add_foreign_key "text_responses", "survey_responders"
  add_foreign_key "text_responses", "text_questions"
end
