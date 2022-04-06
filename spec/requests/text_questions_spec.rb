require 'rails_helper'

RSpec.describe "TextQuestions", type: :request do

  describe "positive tests 1" do
    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: nil)}
    
    describe "POST /api/v1/text_questions/create" do

      it 'returns the text_question if successful' do

        post '/api/v1/text_questions/create', params: {text_question: {question: "test_question", 
        survey_id: survey.id, order: 1}}

        expect(JSON.parse(response.body)["question"]).to eql('test_question')
        expect(JSON.parse(response.body)["survey_id"]).to eql(survey.id)
        expect(JSON.parse(response.body)["order"]).to eql(1)
      end
    end
  end

  describe "positive tests" do 
    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: nil)}
    let!(:survey2) {Survey.create(title: "test2", id: 2, isLive: false, wentLiveAt: nil)}
    let!(:text_question_test) {TextQuestion.create(question: "test question", survey_id: survey.id, id: 1, order: 1)}

    describe "DELETE /api/v1/text_questions/:id" do 

      it 'destroys the text_question if successful' do

        expect {delete '/api/v1/text_questions/1'}.to change(TextQuestion, :count).by(-1)
        expect(JSON.parse(response.body)["notice"]).to eql('Text question was successfully removed.')
      end

    end

    describe "GET /api/v1/text_questions/:id" do 

      it 'returns the specified text_question if successful' do

        get '/api/v1/text_questions/1'

        expect(JSON.parse(response.body)["question"]).to eql('test question')
        expect(JSON.parse(response.body)["id"]).to eql(text_question_test.id)
      end

    end

    describe "PATCH /api/v1/text_questions/:id" do

      context "update all params"
        it 'returns the text_question if successful' do

          patch '/api/v1/text_questions/1', params: {text_question: {question: "test question#2", 
          survey_id: survey2.id, order: 2}}
          
          expect(JSON.parse(response.body)["question"]).to eql('test question#2')
          expect(JSON.parse(response.body)["survey_id"]).to eql(survey2.id)
          expect(JSON.parse(response.body)["order"]).to eql(2)
        end
      end

      context "update question only" do
        it 'update only question and returns the text_question if successful' do

          patch '/api/v1/text_questions/1', params: {text_question: {question: "test question#3"}}
          
          expect(JSON.parse(response.body)["question"]).to eql('test question#3')
          expect(JSON.parse(response.body)["survey_id"]).to eql(survey.id)
        end
      end
      
      context "update survey_id only" do
        it 'update only the survey_id returns the text_question if successful' do

          patch '/api/v1/text_questions/1', params: {text_question: {survey_id: survey2.id}}
          
          expect(JSON.parse(response.body)["question"]).to eql('test question')
          expect(JSON.parse(response.body)["survey_id"]).to eql(survey2.id)
        end
      end

      context "update order only" do
        it 'update only the order returns the text_question if successful' do

          patch '/api/v1/text_questions/1', params: {text_question: {order: 3}}
          
          expect(JSON.parse(response.body)["question"]).to eql('test question')
          expect(JSON.parse(response.body)["order"]).to eql(3)
        end
      end
    end
  end

  describe "negative tests" do
    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: nil)}
    let!(:text_question_test) {TextQuestion.create(question: "test question", survey_id: survey.id, id: 1)}

    describe "POST /api/v1/text_questions/create with incorrect params" do
      context "text_question param is empty" do
        it 'fails due to missing param' do

          post '/api/v1/text_questions/create', params: {}

          expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: text_question')
        end
      end

      context "question param is missing" do
        it 'fails due to missing question' do

          post '/api/v1/text_questions/create', params: {text_question: { survey_id: survey.id, order: 1}}

          expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: question')
        end
      end

      context "survey_id param is missing" do
        it 'fails due to missing survey_id' do

          post '/api/v1/text_questions/create', params: {text_question: {question:"test", order: 1} }

          expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: survey_id')
        end
      end

      context "order param is missing" do
        it 'fails due to missing order' do

          post '/api/v1/text_questions/create', params: {text_question: {question:"test", survey_id: survey.id} }

          expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: order')
        end
      end
    end

    describe "POST /api/v1/text_questions/create with live survey" do
      let!(:survey_live) {Survey.create(title: "test", id: 2, isLive: true, wentLiveAt: DateTime.now)}

      it 'fails due survey id is a live survey' do
        post '/api/v1/text_questions/create', params: {text_question: {question: "test_question", 
        survey_id: survey_live.id, order: 1}}

        expect(JSON.parse(response.body)["notice"]).to eql('Failure! Cannot update live survey')
      end
    end

    describe "POST /api/v1/mc_questions/create with non-existant survey" do

      it 'fails due survey id being invalid' do

        post '/api/v1/text_questions/create', params: {text_question: {question: "test_question", 
        survey_id: 23423423, order: 1}}

        expect(JSON.parse(response.body)["error"]).to eql("Couldn't find Survey with 'id'=23423423")
      end
    end

    describe "DELETE /api/v1/text_questions/:id with non existant id" do 

      it 'returns an error' do
      
        expect {delete '/api/v1/text_questions/100'}.to change(TextQuestion, :count).by(0)
        expect(JSON.parse(response.body)["error"]).to eql("Couldn't find TextQuestion with 'id'=100")
      end

    end

    describe "GET /api/v1/text_questions/:id with non existant id" do 

      it 'returns an error' do

        get '/api/v1/text_questions/100'

        expect(JSON.parse(response.body)["error"]).to eql("Couldn't find TextQuestion with 'id'=100")
      end

    end

    describe "PATCH /api/v1/mc_questions/create with incorrect params" do

      it 'fails due to missing param' do

        patch '/api/v1/text_questions/1', params: {}
        
        expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: text_question')
      end
    end

    describe "PATCH /api/v1/text_questions/create with non existant id" do

      it 'returns an error' do

        patch '/api/v1/text_questions/100', params: {}
        
        expect(JSON.parse(response.body)["error"]).to eql("Couldn't find TextQuestion with 'id'=100")
      end
    end

    describe "PATCH /api/v1/text_questions/:id with live survey" do

      let!(:survey_live) {Survey.create(title: "test", id: 2, isLive: true, wentLiveAt: DateTime.now)}
      let!(:text_question_test_2) {TextQuestion.create(question: "test question", survey_id: survey_live.id, id: 2, order: 1)}

      context "text_question's existing survey_id is live" do
        it 'fails due to live survey' do

          patch '/api/v1/text_questions/2', params: {text_question: { question: "test question#2"} }

          expect(JSON.parse(response.body)["notice"]).to eql('Failure! Cannot update live survey')
        end
      end

      context "new survey_id is live" do 
        it 'fails due to live survey' do

          patch '/api/v1/text_questions/1', params: {text_question: { survey_id: survey_live.id }}

          expect(JSON.parse(response.body)["notice"]).to eql('Failure! Cannot update live survey')
        end
    end
  end
end
