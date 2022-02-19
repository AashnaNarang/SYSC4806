class TextResponse < ApplicationRecord
    belongs_to :text_question
    belongs_to :survey_responder
end
