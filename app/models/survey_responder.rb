class SurveyResponder < ApplicationRecord
    belongs_to :survey
    has_one :text_response
    has_one :mc_response
end
