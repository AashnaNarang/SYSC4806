require 'rails_helper'

RSpec.describe "McResponses", type: :request do

  describe "positive tests" do 

    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: nil)}
    let!(:mc_question_test) {McQuestion.create(question: "test question", survey_id: survey.id, id: 1), mc_options: {options: ["op1", "op2"]}}
    # write in a line here that makes the survey live so that we can add in a survey responder and text response
    # let!(:survey) {Survey.update(isLive: true)}
    let!(:surveyResponder) {SurveyResponder.create(survey_id: survey.id)}

    #------------------------------- YOU STOPPED HERE CONTINUE FINISHING POSITIVE AND NEGATIVE TESTS FOR THIS-------------------------------------

    describe "POST /api/v1/mc_responses/create" do

      it 'returns the mc_responses if successful' do

        post '/api/v1/mc_responses/create', params: {mc_response: {
          mc_option_id:1,
          mc_question_id:mc_question_test.mc_question_id,
          survey_responder_id:surveyResponder.survey_responder_id
      }}
        
      expect(JSON.parse(response.body)["mc_option_id"]).to eql(1)
      expect(JSON.parse(response.body)["mc_question_id"]).to eql(mc_question_test.mc_question_id)
      expect(JSON.parse(response.body)["survey_responder_id"]).to eql(surveyResponder.survey_responder_id)
      end

    end

  end

  describe "negative tests" do
    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: nil)}
    let!(:mc_question_test) {McQuestion.create(question: "test question", survey_id: survey.id, id: 1), mc_options: {options: ["op1", "op2"]}}
    # write in a line here that makes the survey live so that we can add in a survey responder and text response
    # let!(:survey) {Survey.update(isLive: true)}
    let!(:surveyResponder) {SurveyResponder.create(survey_id: survey.id)}

    describe "POST /api/v1/mc_responses/create with incorrect params" do

      it 'fails due to missing param' do

        post '/api/v1/mc_responses/create', params: {mc_response: {
          mc_option_id:1,
          mc_question_id:mc_question_test.mc_question_id
      }}

        expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: survey_responder_id')
      end

    end

  end

end
