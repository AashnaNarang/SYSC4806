require 'rails_helper'

RSpec.describe "TextResponses", type: :request do

  describe "positive tests" do 

    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: nil)}
    let!(:text_question_test) {TextQuestion.create(question: "test question", survey_id: survey.id, id: 1)}
    # write in a line here that makes the survey live so that we can add in a survey responder and text response
    # let!(:survey) {Survey.update(isLive: true)}
    let!(:surveyResponder) {SurveyResponder.create(survey_id: survey.id)}

    describe "POST /api/v1/text_responses/create" do

      it 'returns the test_response if successful' do

        post '/api/v1/text_responses/create', params: 
        {text_response: 
          {
            response:"test_answer",
            text_question_id: text_question_test.text_question_id,
            survey_responder_id: surveyResponder.survey_responder_id
          }
        }

        expect(JSON.parse(response.body)["response"]).to eql('test_answer')
        expect(JSON.parse(response.body)["text_question_id"]).to eql(text_question_test.text_question_id)
        expect(JSON.parse(response.body)["survey_responder_id"]).to eql(surveyResponder.survey_responder_id)
      end
    end
  end

  describe "negative tests" do
    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: nil)}
    let!(:text_question_test) {TextQuestion.create(question: "test question", survey_id: survey.id, id: 1)}
    # write in a line here that makes the survey live so that we can add in a survey responder and text response
    # let!(:survey) {Survey.update(isLive: true)}
    let!(:surveyResponder) {SurveyResponder.create(survey_id: survey.id)}

    describe "POST /api/v1/text_responses/create with incorrect params" do
      context "text_response param is empty" do
        it 'fails due to missing param' do

          post '/api/v1/text_responses/create', params: {}

          expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: text_response')
        end
      end

      context "response param is missing" do
        it 'fails due to missing response' do

          post '/api/v1/text_questions/create', params: {text_question: {
            text_question_id: text_question_test.text_question_id,
            survey_responder_id: surveyResponder.survey_responder_id
          }}

          expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: response')
        end
      end

      context "text_question_id param is missing" do
        it 'fails due to missing text_question_id' do

          post '/api/v1/text_questions/create', params: {text_question: {
            response:"test_answer",
            survey_responder_id: surveyResponder.survey_responder_id
          } }

          expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: text_question_id')
        end
      end

      context "survey_responder_id param is missing" do
        it 'fails due to missing survey_responder_id' do

          post '/api/v1/text_questions/create', params: {text_question: {
            response:"test_answer",
            text_question_id: text_question_test.text_question_id
          }}

          expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: survey_responder_id')
        end
      end

    end
  end
end
