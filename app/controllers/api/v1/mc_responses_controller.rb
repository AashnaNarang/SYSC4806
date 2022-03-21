class Api::V1::McQuestionsController < ApplicationController
    # before_action :set_mc_question, only: [:edit]
    skip_before_action :verify_authenticity_token
  
    # POST /mc_questions or /mc_questions.json
    def create

        begin
          find_question(question_response_params_create[:mc_question_id])
        rescue ActiveRecord::ActiveRecordError => error
          render json: {error: error.message}
          return
        end

        # Add reponse into database if survey is live
        if @mc_question.survey.isLive
          @mc_response = McResponse.new(question_response_params_create)

          if @mc_response.save
            render json: @mc_response
          else
            render json: {notice: "Failure! Could not save Text Response due to #{@mc_response.errors.full_messages}"}
          end
        else
          render json: {notice: 'Failure! Cannot update when survey not live'}
        end

        # begin 
        #   @mc_question = McQuestion.new(mc_question_params)
        #   options = mc_option_params
        # rescue ActionController::ParameterMissing => error
        #   render json: {error: error.message}
        #   return
        # end

        # options[:options].each do |option|
        #   @mc_question.mc_options << McOption.new(option: option)
        # end

        # if @mc_question.save
        #   render json: @mc_question
        # else
        #   render json: {notice: "Failure! Could not save McQuestion due to #{@mc_question.errors.full_messages}"}
        # end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      # def set_mc_question
      #   begin
      #     @mc_question = McQuestion.find(params[:id])
      #   rescue ActiveRecord::ActiveRecordError => error
      #     render json: {error: error.message}
      #   end
      # end

      # # Only allow a list of trusted parameters through.
      # def mc_question_params
      #   params.require(:mc_question).permit(:question, :survey_id)
      # end

      # # Only allow a list of trusted parameters through.
      # def mc_option_params
      #   params.require(:mc_options).permit(:options => [])
      # end

      def find_question(mc_question_id))
        @mc_question = McQuestion.find(mc_question_id)
      end

      # Only allow a list of trusted parameters through for the create method
      def question_response_params_create
        params.require(:mc_response).permit(:mc_option_id, :mc_question_id, :survey_responder_id).tap do |question_params|
          question_params.require(:mc_option_id))
          question_params.require(:mc_question_id)
          question_params.require(:survey_responder_id)
        end
      end
  end
