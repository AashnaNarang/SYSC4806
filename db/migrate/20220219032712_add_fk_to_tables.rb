class AddFkToTables < ActiveRecord::Migration[7.0]
  def change
    add_reference :text_questions, :survey, foreign_key: true
    add_reference :mc_questions, :survey, foreign_key: true
    add_reference :survey_responders, :survey, foreign_key: true
    add_reference :mc_responses, :mc_question, foreign_key: true
    add_reference :text_responses, :text_question, foreign_key: true
    add_reference :mc_options, :mc_question, foreign_key: true
    add_reference :mc_responses, :mc_option, foreign_key: true
    add_reference :text_responses, :survey_responder, foreign_key: true
    add_reference :mc_responses, :survey_responder, foreign_key: true
  end
end
