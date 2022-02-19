class Survey < ApplicationRecord
    has_many :text_questions
    has_many :mc_questions
    has_many :survey_responders
end
