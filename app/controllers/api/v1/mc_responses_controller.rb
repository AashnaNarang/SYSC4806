class Api::V1::McQuestionsController < ApplicationController
    before_action :set_mc_question, only: [:edit]
    skip_before_action :verify_authenticity_token
  
    # POST /mc_questions or /mc_questions.json
    def create
        begin 
          @mc_question = McQuestion.new(mc_question_params)
          options = mc_option_params
        rescue ActionController::ParameterMissing => error
          render json: {error: error.message}
          return
        end

        options[:options].each do |option|
          @mc_question.mc_options << McOption.new(option: option)
        end

        if @mc_question.save
          render json: @mc_question
        else
          render json: {notice: "Failure! Could not save McQuestion due to #{@mc_question.errors.full_messages}"}
        end
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
  end
