class McQuestion < ApplicationRecord
    belongs_to :survey
    has_many :mc_responses
    has_many :mc_options
end
