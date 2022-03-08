require 'rails_helper'

RSpec.describe "McQuestions", type: :request do
  describe "POST /api/v1/mc_questions/create" do

    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: Time.now)}

    it 'returns the mc_question if successful' do

    post '/api/v1/mc_questions/create', params: {mc_question: {question: "test_question", 
      survey_id: survey.id}, mc_options: {options: ["op1", "op2"]}}
      
      expect(JSON.parse(response.body)["question"]).to eql('test_question')
    end
  end

  describe "GET /api/v1/mc_questions/index" do 
    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: Time.now)}
    let!(:mc_question_test) {McQuestion.create(question: "test question", survey_id: survey.id)}

    it 'returns all the mc_questions if successful' do

    get '/api/v1/mc_questions/index'

      expect(JSON.parse(response.body)[0]["question"]).to eql('test question')
    end

  end

  describe "DELETE /api/v1/mc_questions/:id" do 
    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: Time.now)}
    let!(:mc_question_test) {McQuestion.create(question: "test question", survey_id: survey.id, id: 1)}

    it 'destroys the mc_questions if successful' do
    
    expect do
      delete '/api/v1/mc_questions/1', params: {id: mc_question_test.id}
    end.to change(McQuestion, :count).by(-1)
      expect(JSON.parse(response.body)["notice"]).to eql('McQuestion was successfully removed')
    end

  end

  describe "GET /api/v1/mc_questions/:id" do 
    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: Time.now)}
    let!(:mc_question_test) {McQuestion.create(question: "test question", survey_id: survey.id)}

    it 'returns the specified mc_questions if successful' do

    get '/api/v1/mc_questions/1'

      expect(JSON.parse(response.body)["question"]).to eql('test question')
    end

  end

  describe "PATCH /api/v1/mc_questions/create" do
    
    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: Time.now)}
    let!(:mc_question_test) {McQuestion.create(question: "test question", survey_id: survey.id, id: 1)}

    it 'returns the mc_question if successful' do

      patch '/api/v1/mc_questions/1', params: {mc_question: {question: "test question#2", 
      survey_id: survey.id}, mc_options: {options: ["op1", "op2"]}}
      
      expect(JSON.parse(response.body)["question"]).to eql('test question#2')
    end
  end

end
