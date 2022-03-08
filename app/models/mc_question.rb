class McQuestion < ApplicationRecord
    belongs_to :survey
    has_many :mc_responses, dependent: :destroy
    has_many :mc_options, dependent: :destroy
end
