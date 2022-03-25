class Api::V1::TextQuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /text_questions/1 or /text_questions/1.json
  def show
    render json: @text_question
  end

  # POST /text_questions or /text_questions.json
  def create
    begin
      # Check given survey exists
      begin
        find_survey(question_params_create[:survey_id])
      rescue ActiveRecord::ActiveRecordError => error
        render json: {error: error.message}
        return
      end

      # Add question if survey is not live
      if !@survey.isLive
        @text_question = TextQuestion.new(question_params_create)

        if @text_question.save
          render json: @text_question
        else
          render json: {notice: "Failure! Could not save Text Question due to #{@text_question.errors.full_messages}"}
        end
      else
        render json: {notice: 'Failure! Cannot update live survey'}
      end
    rescue ActionController::ParameterMissing => error
      render json: {error: error.message}
    end
  end

  # PATCH/PUT /text_questions/1 or /text_questions/1.json
  def update
    if !@text_question.survey.isLive
      begin

        # Safety check if updating the survey id
        survey_id = question_params_update[:survey_id]
        if(survey_id)
          # validate new survey
          begin
            find_survey(survey_id)
          rescue ActiveRecord::ActiveRecordError => error
            render json: {error: error.message}
            return
          end
          if @survey.isLive
            render json: {notice: 'Failure! Cannot update live survey'}
            return
          end
        end

        if @text_question.update(question_params_update)
          render json: @text_question
        else
          render json: {notice: "Failure! Could not save Text Question due to #{@text_question.errors.full_messages}"}
        end
      rescue ActionController::ParameterMissing => error
        render json: {error: error.message}
      end
    else
      render json: {notice: 'Failure! Cannot update live survey'}
    end
  end

  # DELETE /text_questions/1 or /text_questions/1.json
  def destroy
    @text_question.destroy

    render json: { notice: 'Text question was successfully removed.' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      begin
        @text_question = TextQuestion.find(params[:id])
      rescue ActiveRecord::ActiveRecordError => error
        render json: {error: error.message}
      end
    end

    def find_survey(survey_id)
        @survey = Survey.find(survey_id)
    end

    # Only allow a list of trusted parameters through.
    def question_params_update
      params.require(:text_question).permit(:question, :survey_id, :order)
    end

    # Only allow a list of trusted parameters through for the create method
    def question_params_create
      params.require(:text_question).permit(:question, :survey_id, :order).tap do |question_params|
        question_params.require(:question)
        question_params.require(:survey_id)
        question_params.require(:order)
      end
    end
end
