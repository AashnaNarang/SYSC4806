require "test_helper"

class Api::V1::SurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survey = surveys(:one)
    @survey2 = surveys(:two)
  end

  test "should get index" do
    get surveys_url
    assert_response :success
  end

  test "should get new" do
    get new_survey_url
    assert_response :success
  end

  test "should create survey" do
    assert_difference("Survey.count") do
      post surveys_url, params: { survey: { isLive: @survey.isLive, title: @survey.title} }
    end
    assert_redirected_to survey_url(Survey.last)
    assert_nil(Survey.last.wentLiveAt, "Test not successful!")
  end

  test "should create survey with isLive is true" do
    assert_difference("Survey.count") do
      post surveys_url, params: { survey: { isLive: @survey2.isLive, title: @survey2.title} }
    end
    assert_redirected_to survey_url(Survey.last)
    assert_not_nil(Survey.last.wentLiveAt, "Test not successful!")
  end

  test "should show survey" do
    get survey_url(@survey)
    assert_response :success
  end

  test "should get edit" do
    get edit_survey_url(@survey)
    assert_response :success
  end

  test "should update survey" do
    patch survey_url(@survey), params: { survey: { isLive: @survey.isLive, title: @survey.title} }
    assert_redirected_to survey_url(@survey)
    assert_nil(Survey.last.wentLiveAt, "Test not successful!")
  end

  test "should update survey with isLive is true" do
    patch survey_url(@survey2), params: { survey: { isLive: @survey2.isLive, title: @survey2.title} }
    assert_redirected_to survey_url(@survey2)
    assert_not_nil(Survey.last.wentLiveAt, "Test not successful!")
  end

  test "should get text questions from survey" do
    @textquestion = textquestions(:one)
    @textquestion.survey_id = @survey.id
    @textquestion2 = textquestions(:two)
    @textquestion2.survey_id = @survey2.id
    get "/surveys/#{@survey.id}/textquestions"
    #assert response only includes @textquesiton
  end

  test "should destroy survey" do
    assert_difference("Survey.count", -1) do
      delete survey_url(@survey)
    end

    assert_redirected_to surveys_url
  end
end
