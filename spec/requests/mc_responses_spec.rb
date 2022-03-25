require 'rails_helper'

RSpec.describe "McResponses", type: :request do

  describe "positive tests" do 

    let!(:survey) {Survey.create(title: "test", id: 1, isLive: true, wentLiveAt: nil)}
    let!(:mc_option1) {McOption.create(option: "op1")}
    let!(:mc_option2) {McOption.create(option: "op2")}
    let!(:mc_question_test) {McQuestion.create(question: "test question", survey_id: survey.id, id: 1)}
    let!(:surveyResponder) {SurveyResponder.create(survey_id: survey.id)}

    describe "POST /api/v1/mc_responses/create" do

      it 'returns the mc_responses if successful' do
        mc_question_test.mc_options << mc_option1
        mc_question_test.mc_options << mc_option2

        post '/api/v1/mc_responses/create', params: {mc_response: {
          mc_option_id:1,
          mc_question_id:mc_question_test.id,
          survey_responder_id:surveyResponder.id
      }}
      expect(JSON.parse(response.body)["mc_option_id"]).to eql(1)
      expect(JSON.parse(response.body)["mc_question_id"]).to eql(mc_question_test.id)
      expect(JSON.parse(response.body)["survey_responder_id"]).to eql(surveyResponder.id)
      end

    end

  end

  # describe "negative tests" do
  #   let!(:survey) {Survey.create(title: "test", id: 1, isLive: true, wentLiveAt: nil)}
  #   let!(:mc_option1) {McOption.create(option: "op1")}
  #   let!(:mc_option2) {McOption.create(option: "op2")}
  #   let!(:mc_question_test) {McQuestion.create(question: "test question", survey_id: survey.id, id: 1)}
  #   let!(:surveyResponder) {SurveyResponder.create(survey_id: survey.id)}

  #   describe "POST /api/v1/mc_responses/create with incorrect params" do

  #     context "mc_response param is empty" do
  #       it 'fails due to missing param' do
  #         mc_question_test.mc_options << mc_option1
  #         mc_question_test.mc_options << mc_option2

  #         post '/api/v1/mc_responses/create', params: {}

  #         expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: mc_response')
  #       end
  #     end

  #     context "mc_option_id param is missing" do
  #       it 'fails due to missing mc_option_id' do
  #         mc_question_test.mc_options << mc_option1
  #         mc_question_test.mc_options << mc_option2

  #         post '/api/v1/mc_responses/create', params: { mc_response: {
  #         mc_question_id:mc_question_test.id,
  #         survey_responder_id:surveyResponder.id
  #     }}

  #         expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: mc_option_id')
  #       end
  #     end

  #     context "mc_question_id param is missing" do
  #       it 'fails due to missing mc_question_id' do
  #         mc_question_test.mc_options << mc_option1
  #         mc_question_test.mc_options << mc_option2

  #         post '/api/v1/mc_responses/create', params: {mc_response: {
  #           mc_option_id:1,
  #           survey_responder_id: surveyResponder.id
  #         }}

  #         expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: mc_question_id')
  #       end
  #     end

  #     context "survey_responder_id param is missing" do
  #       it 'fails due to missing survey_responder_id' do
  #         mc_question_test.mc_options << mc_option1
  #         mc_question_test.mc_options << mc_option2

  #         post '/api/v1/mc_responses/create', params: {mc_response: {
  #           mc_option_id:1,
  #           mc_question_id:mc_question_test.id
  #         }}

  #         expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: survey_responder_id')
  #       end
  #     end

  #   end

  # end

end
