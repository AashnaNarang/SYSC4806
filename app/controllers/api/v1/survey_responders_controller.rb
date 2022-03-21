class Api::V1::SurveyRespondersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  # POST /surveys or /surveys.json
  def create

    begin
      find_survey(survey_responder_params_create[:survey_id])
    rescue ActiveRecord::ActiveRecordError => error
      render json: {error: error.message}
      return
    end

    # Add reponse into database if survey is live
    if @survey.isLive
      
      begin
        @survey_responder = SurveyResponder.new()
      rescue ActionController::ParameterMissing => error
        render json: {error: error.message}
        return
      end

      if @survey_responder.save
        render json: @survey_responder
      else
        render json: @survey_responder.errors
      end
    else
      render json: {notice: 'Failure! Cannot create responder when survey not live'}
    end
  end

  # PATCH/PUT /surveys/1 or /surveys/1.json
  def update
    if @survey.isLive
      begin
        params = survey_responder_params_update
        params[:respondedAt] = DateTime.now()

        if @survey_responder.update(params)
          render json: @survey_responder
        else
          render json: {notice: "Failure! Could not save survey responder due to #{@survey_responder.errors.full_messages}"}
        end
      rescue ActionController::ParameterMissing => error
        render json: {error: error.message}
      end
    else
      render json: {notice: 'Failure! Cannot update survey that is not live'}
    end
  end

  private

    def find_survey(survey_id)
      @survey = Survey.find(survey_id)
    end

    # Only allow a list of trusted parameters through for the update method
    def survey_responder_params_update
      params.require(:survey_responder).permit(:respondedAt)
    end

    # Only allow a list of trusted parameters through for the create method
    def survey_responder_params_create
      params.require(:survey_responder).permit(:survey_id).tap do |question_params|
        question_params.require(:survey_id)
      end
    end

end
