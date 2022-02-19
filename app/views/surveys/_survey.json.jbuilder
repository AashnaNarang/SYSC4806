json.extract! survey, :id, :title, :isLive, :wentLiveAt, :created_at, :updated_at
json.url survey_url(survey, format: :json)
