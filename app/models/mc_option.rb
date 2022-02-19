class McOption < ApplicationRecord
    belongs_to :mc_question
    has_one :mc_response
end
