class SurveyResponder < ApplicationRecord
    belongs_to :survey
    has_one :text_response, :dependent => :destroy
    has_one :mc_response, :dependent => :destroy
end
