class McResponse < ApplicationRecord
    belongs_to :mc_question
    belongs_to :survey_responder
    belongs_to :mc_option
end
