require 'rails_helper'

RSpec.describe "SurveyResponders", type: :request do

  describe "positive tests" do 

    let!(:survey) {Survey.create(title: "test", id: 1, isLive: true, wentLiveAt: nil)}
    let!(:survey_responder) {SurveyResponder.create(id: 1, respondedAt: nil, survey_id: survey.id)}

    describe "POST /api/v1/survey_responders/create" do

      context "isLive is false" do
        it 'returns the survey if successful' do

          post '/api/v1/survey_responders/create', params: {
              survey_responder: {
                survey_id:survey.id
              }
          }
          

          expect(JSON.parse(response.body)["survey_id"]).to eql(survey.id)
        end
      end
    end

    describe "PATCH /api/v1/survey_responders/:id" do

      context "update both params" do
        it 'returns the survey if successful' do

          patch '/api/v1/survey_responders/1', params: {
            survey_responder: {
                survey_responder_id: 1
            }
        }
          
          expect(JSON.parse(response.body)["respondedAt"]).not_to be(nil)
        end
      end
    end
  end

  # describe "negative tests" do
  #   let!(:survey) {Survey.create(title: "test", id: 1, isLive: true, wentLiveAt: nil)}
  #   let!(:survey_responder) {SurveyResponder.create(id: 1, respondedAt: nil, survey_id: survey.id)}

  #   describe "POST /api/v1/survey_responders/create with incorrect params" do
      
  #     context "survey_responder param is empty" do
  #       it 'fails due to missing param' do

  #         post '/api/v1/survey_responders/create', params: {}

  #         expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: survey_responder')
  #       end
  #     end

  #     context "survey_id param is missing" do
  #       it 'fails due to missing survey_id' do

  #         post '/api/v1/survey_responders/create', params: {survey_responder: {}}

  #         expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: survey_id')
  #       end
  #     end
  #   end

  #   describe "PATCH /api/v1/survey_responders/:id with incorrect params" do
  #     context "survey_responder param is empty" do
  #       it 'fails due to missing param' do

  #         patch '/api/v1/survey_responders/1', params: {}
          
  #         expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: survey_responder')
  #       end
  #     end
  #   end
  # end
end
