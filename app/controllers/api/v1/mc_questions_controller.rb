class Api::V1::McQuestionsController < ApplicationController
    before_action :set_mc_question, only: [:show, :edit, :update, :destroy]
    skip_before_action :verify_authenticity_token
  
    # GET /mc_questions/1 or /mc_questions/1.json
    def show
        render json: @mc_question.to_json(include: :mc_options)
    end
  
    # POST /mc_questions or /mc_questions.json
    def create
        begin 
          @mc_question = McQuestion.new(mc_question_params)
          options = mc_option_params
        rescue ActionController::ParameterMissing => error
          render json: {error: error.message}
          return
        end

        begin
          find_survey(mc_question_params[:survey_id])
        rescue ActiveRecord::ActiveRecordError => error
          render json: {error: error.message}
          return
        end
  
        # Add question if survey is not live
        if !@survey.isLive
          options[:options].each do |option|
            @mc_question.mc_options << McOption.new(option: option)
          end

          if @mc_question.save
            render json: @mc_question
          else
            render json: {notice: "Failure! Could not save McQuestion due to #{@mc_question.errors.full_messages}"}
          end 
        else
          render json: {notice: 'Failure! Cannot update live survey'}
        end

    end
  
    # PATCH/PUT /mc_questions/1 or /mc_questions/1.json
    def update
      if @mc_question.survey.isLive == false
        begin
          if @mc_question.update(mc_question_params)

            if @mc_question.mc_options.any?
              @mc_question.mc_options.destroy_all
            end

            options = mc_option_params
            options[:options].each do |option|
              @mc_question.mc_options << McOption.create(option: option)
            end

            render json: @mc_question
          else
            render json: {notice: "Failure! Could not save McQuestion due to #{@mc_question.errors.full_messages}"}
          end
        rescue ActionController::ParameterMissing => error
          render json: {error: error.message}
        end
      else
        render json: {notice: 'Failure! Cannot update live survey'}
      end
    end
  
    # DELETE /mc_questions/1 or /mc_questions/1.json
    def destroy
      @mc_question.destroy
  
      render json: { notice: 'McQuestion was successfully removed' }
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_mc_question
        begin
          @mc_question = McQuestion.find(params[:id])
        rescue ActiveRecord::ActiveRecordError => error
          render json: {error: error.message}
        end
      end

      # Only allow a list of trusted parameters through.
      def mc_question_params
        params.require(:mc_question).permit(:question, :survey_id)
      end

      # Only allow a list of trusted parameters through.
      def mc_option_params
        params.require(:mc_options).permit(:options => [])
      end

      def find_survey(survey_id)
        @survey = Survey.find(survey_id)
    end
  end
