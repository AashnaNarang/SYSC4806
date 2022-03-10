require 'rails_helper'

RSpec.describe "Surveys", type: :request do

  describe "positive tests" do 

    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: nil)}
    let!(:survey2) {Survey.create(title: "test2", id: 2, isLive: true, wentLiveAt: DateTime.now())}

    describe "GET /api/v1/surveys/index" do

      it 'returns all surveys' do

        get '/api/v1/surveys/index'

        expect(JSON.parse(response.body)[0]["id"]).to eql(survey.id)
        expect(JSON.parse(response.body)[1]["id"]).to eql(survey2.id)
      end
    end

    describe "POST /api/v1/surveys/create" do

      context "isLive is false" do
        it 'returns the survey if successful' do

          expect { post '/api/v1/surveys/create', params: {survey: {title: "New Title", 
          isLive: false}}}.to change(Survey, :count).by(1)

          expect(JSON.parse(response.body)["title"]).to eql('New Title')
          expect(JSON.parse(response.body)["wentLiveAt"]).to eql(nil)
        end
      end

      context "isLive is true" do
        it 'returns the survey if successful' do

          expect { post '/api/v1/surveys/create', params: {survey: {title: "New Title", 
          isLive: true}}}.to change(Survey, :count).by(1)
  
          expect(JSON.parse(response.body)["title"]).to eql('New Title')
          expect(JSON.parse(response.body)["wentLiveAt"]).not_to eql(nil)
        end
      end 
    end

    describe "DELETE /api/v1/surveys/:id" do 

      it 'destroys the survey if successful' do

        expect {delete '/api/v1/surveys/1'}.to change(Survey, :count).by(-1)
        expect(JSON.parse(response.body)["notice"]).to eql('Survey was successfully removed.')
      end

    end

    describe "GET /api/v1/surveys/:id" do 

      it 'returns the specified surveys if successful' do

        get '/api/v1/surveys/1'

        expect(JSON.parse(response.body)["title"]).to eql('test')
        expect(JSON.parse(response.body)["id"]).to eql(survey.id)
      end

    end

    describe "PATCH /api/v1/surveys/:id" do

      context "update both params" do
        it 'returns the survey if successful' do

          patch '/api/v1/surveys/1', params: {survey: {title: "New Title 2", 
          isLive: true}}
          
          expect(JSON.parse(response.body)["title"]).to eql('New Title 2')
          expect(JSON.parse(response.body)["isLive"]).to eql(true)
          expect(JSON.parse(response.body)["wentLiveAt"]).not_to be(nil)
        end
      end

      context "update title only" do
        it 'update only title and returns the survey if successful' do

          patch '/api/v1/surveys/1', params: {survey: {title: "New Title 3"}}
          
          expect(JSON.parse(response.body)["title"]).to eql('New Title 3')
          expect(JSON.parse(response.body)["isLive"]).to eql(false)
          expect(JSON.parse(response.body)["wentLiveAt"]).to eql(nil)
        end
      end
      
      context "update isLive only" do
        it 'update only the survey_id returns the survey if successful' do

          patch '/api/v1/surveys/1', params: {survey: {isLive: true}}
          
          expect(JSON.parse(response.body)["title"]).to eql('test')
          expect(JSON.parse(response.body)["isLive"]).to eql(true)
          expect(JSON.parse(response.body)["wentLiveAt"]).not_to be(nil)
        end
      end
    end
  end

  describe "negative tests" do
    let!(:survey) {Survey.create(title: "test", id: 1, isLive: false, wentLiveAt: nil)}
    let!(:survey2) {Survey.create(title: "test2", id: 2, isLive: true, wentLiveAt: DateTime.now())}

    describe "POST /api/v1/surveys/create with incorrect params" do
      context "suvey param is empty" do
        it 'fails due to missing param' do

          post '/api/v1/surveys/create', params: {}

          expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: survey')
        end
      end

      context "title param is missing" do
        it 'fails due to missing title' do

          post '/api/v1/surveys/create', params: {survey: {isLive: true}}

          expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: title')
        end
      end

      context "isLive param is missing" do
        it 'fails due to missing isLive' do

          post '/api/v1/surveys/create', params: {survey: {title: "New Title 2"}}

          expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: isLive')
        end
      end
    end

    describe "DELETE /api/v1/surveys/:id with non existant id" do 

      it 'returns an error' do
      
        expect {delete '/api/v1/surveys/100'}.to change(Survey, :count).by(0)
        expect(JSON.parse(response.body)["error"]).to eql("Couldn't find Survey with 'id'=100")
      end

    end

    describe "GET /api/v1/surveys/:id with non existant id" do 

      it 'returns an error' do

        get '/api/v1/surveys/100'

        expect(JSON.parse(response.body)["error"]).to eql("Couldn't find Survey with 'id'=100")
      end

    end

    describe "PATCH /api/v1/surveys/create with incorrect params" do

      it 'fails due to missing param' do

        patch '/api/v1/surveys/1', params: {}
        
        expect(JSON.parse(response.body)["error"]).to eql('param is missing or the value is empty: survey')
      end
    end

    describe "PATCH /api/v1/surveys/create with non existant id" do

      it 'returns an error' do

        patch '/api/v1/surveys/100', params: {}
        
        expect(JSON.parse(response.body)["error"]).to eql("Couldn't find Survey with 'id'=100")
      end
    end

    describe "PATCH /api/v1/surveys/:id with live survey" do

      it 'fails due to live survey' do

        patch '/api/v1/surveys/2', params: {text_question: { question: "test question#2"} }

        expect(JSON.parse(response.body)["notice"]).to eql('Failure! Cannot update live survey')
      end
    end
  end
end
