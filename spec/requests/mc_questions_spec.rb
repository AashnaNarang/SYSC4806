require 'rails_helper'

RSpec.describe "McQuestions", type: :request do

  describe "positive tests" do 

    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: Time.now)}
    let!(:mc_question_test) {McQuestion.create(question: "test question", survey_id: survey.id, id: 1)}

    describe "POST /api/v1/mc_questions/create" do

      it 'returns the mc_question if successful' do

        post '/api/v1/mc_questions/create', params: {mc_question: {question: "test_question", 
        survey_id: survey.id}, mc_options: {options: ["op1", "op2"]}}
        
        expect(JSON.parse(response.body)["question"]).to eql('test_question')
      end
    end

    describe "DELETE /api/v1/mc_questions/:id" do 

      it 'destroys the mc_questions if successful' do
      
        expect {delete '/api/v1/mc_questions/1', params: {id: mc_question_test.id}}.to change(McQuestion, :count).by(-1)
        expect(JSON.parse(response.body)["notice"]).to eql('McQuestion was successfully removed')
      end

    end

    describe "GET /api/v1/mc_questions/:id" do 

      it 'returns the specified mc_questions if successful' do

        get '/api/v1/mc_questions/1'

        expect(JSON.parse(response.body)["question"]).to eql('test question')
      end

    end

    describe "PATCH /api/v1/mc_questions/create" do

      it 'returns the mc_question if successful' do

        patch '/api/v1/mc_questions/1', params: {mc_question: {question: "test question#2", 
        survey_id: survey.id}, mc_options: {options: ["op1", "op2"]}}
        
        expect(JSON.parse(response.body)["question"]).to eql('test question#2')
      end
    end
  end

  describe "negative tests" do
    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: Time.now)}
    let!(:mc_question_test) {McQuestion.create(question: "test question", survey_id: survey.id, id: 1)}

    describe "POST /api/v1/mc_questions/create with incorrect params" do

      it 'fails due to missing param' do

        post '/api/v1/mc_questions/create', params: {mc_options: {options: ["op1", "op2"]}}

        expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: mc_question')
      end
    end

    describe "DELETE /api/v1/mc_questions/:id with non existant id" do 

      it 'returns an error' do
      
        expect {delete '/api/v1/mc_questions/100', params: {id: 100}}.to change(McQuestion, :count).by(0)
        expect(JSON.parse(response.body)["error"]).to eql("Couldn't find McQuestion with 'id'=100")
      end

    end

    describe "GET /api/v1/mc_questions/:id with non existant id" do 

      it 'returns an error' do

        get '/api/v1/mc_questions/100'

        expect(JSON.parse(response.body)["error"]).to eql("Couldn't find McQuestion with 'id'=100")
      end

    end

    describe "PATCH /api/v1/mc_questions/create with incorrect params" do

      it 'fails due to missing param' do

        patch '/api/v1/mc_questions/1', params: {mc_options: {options: ["op1", "op2"]}}
        
        expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: mc_question')
      end
    end

    describe "PATCH /api/v1/mc_questions/create with live survey" do

      let!(:survey_live) {Survey.create(title: "test", id: 2, isLive: true, wentLiveAt: Time.now)}
      let!(:mc_question_test_2) {McQuestion.create(question: "test question", survey_id: survey_live.id, id: 2)}

      it 'fails due to live survey' do

        patch '/api/v1/mc_questions/2', params: {mc_question: {question: "test question#2", 
        survey_id: survey_live.id}, mc_options: {options: ["op1", "op2"]}}

        expect(JSON.parse(response.body)["notice"]).to eql('Failure! Cannot update live survey')
      end
    end
  end

end
