class Api::V1::TextResponsesController < ApplicationController
  skip_before_action :verify_authenticity_token

   # POST /text_questions or /text_questions.json
  def create
    begin
      # Check that text question exists
      begin
        find_question(question_response_params_create[:text_question_id])
      rescue ActiveRecord::ActiveRecordError => error
        render json: {error: error.message}
        return
      end

      # Add reponse into database if survey is live
      if @text_question.survey.isLive
        @text_response = TextResponse.new(question_response_params_create)

        if @text_response.save
          render json: @text_response
        else
          render json: {notice: "Failure! Could not save Text Response due to #{@text_response.errors.full_messages}"}
        end
      else
        render json: {notice: 'Failure! Cannot update when survey not live'}
      end
    rescue ActionController::ParameterMissing => error
      render json: {error: error.message}
    end
  end

  private

    def find_survey(survey_id)
        @survey = Survey.find(survey_id)
    end

    def find_question(text_question_id)
        @text_question = TextQuestion.find(text_question_id)
    end

    # Only allow a list of trusted parameters through for the create method
    def question_response_params_create
      params.require(:text_response).permit(:response, :text_question_id, :survey_responder_id).tap do |question_params|
        question_params.require(:response)
        question_params.require(:text_question_id)
        question_params.require(:survey_responder_id)
      end
    end
end
