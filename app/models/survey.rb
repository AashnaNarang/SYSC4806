class Survey < ApplicationRecord
    has_many :text_questions, :dependent => :destroy
    has_many :mc_questions, :dependent => :destroy
    has_many :survey_responders, :dependent => :destroy
end
