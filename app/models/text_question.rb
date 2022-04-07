class TextQuestion < ApplicationRecord
    belongs_to :survey
    has_many :text_responses, :dependent => :destroy
end
