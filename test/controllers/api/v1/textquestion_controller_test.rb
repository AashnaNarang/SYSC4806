require "test_helper"

class Api::V1::TextquestionControllerTest < ActionDispatch::IntegrationTest
  setup do
    survey = surveys(:one)
    @survey = Survey.new({ isLive: survey.isLive, title: survey.title})
    @survey2 = surveys(:two)
    @textquestion = textquestions(:one)
    @textquestion.survey_id = @survey.id
    @textquestion2 = textquestions(:two)
    @textquestion2.survey_id = @survey.id
  end

  test "should create text question" do
    assert_difference("TextQuestion.count") do
      post "/textquestions/create", params: { textquestion: { question: @textquestion.question, survey_id: @survey.id} }
    end
    # assert reponse = TextQuestion.last and fields = the ones inputted
  end
  
  test "should update text question" do
    patch "/textquestions/#{@textquestion.id}", params: { textquestion: { question: "new question"} }
    # assert reponse = TextQuestion.last and fields = the ones inputted
  end

  test "should update text question and change survey id" do
    patch "/textquestions/#{@textquestion.id}", params: { textquestion: { question: "new question", survey_id: @survey2.id } }
    # assert reponse = TextQuestion.last and fields = the ones inputted
  end

  test "should destroy textquestion" do
    assert_difference("Survey.count", -1) do
      delete "/textquestions/#{@textquestion.id}"
    end
  end

end
