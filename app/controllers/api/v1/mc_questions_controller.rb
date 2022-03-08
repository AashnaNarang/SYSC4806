class Api::V1::McQuestionsController < ApplicationController
    before_action :set_mc_question, only: [:show, :edit, :update, :destroy]
    skip_before_action :verify_authenticity_token

    # GET /mc_questions or /mc_questions.json
    def index
      @mc_questions = McQuestion.all
      render json: @mc_questions.to_json(include: :mc_options)
    end
  
    # GET /mc_questions/1 or /mc_questions/1.json
    def show
        render json: @mc_question.to_json(include: :mc_options)
    end
  
    # POST /mc_questions or /mc_questions.json
    def create
        @mc_question = McQuestion.new(params.require(:mc_question).permit(:question, :survey_id))
        options = params.require(:mc_options).permit(:options => [])

        options[:options].each do |option|
          @mc_question.mc_options << McOption.new(option: option)
        end

        if @mc_question.save
          render json: @mc_question
        else
          render json: {notice: "Failure! Could not save McQuestion due to #{@mc_question.errors.full_messages}"}
        end
    end
  
    # PATCH/PUT /mc_questions/1 or /mc_questions/1.json
    def update
      if @mc_question.survey.isLive == false
        if @mc_question.update(params.require(:mc_question).permit(:question, :survey_id))

          if @mc_question.mc_options.any?
            @mc_question.mc_options.destroy_all
          end

          options = params.require(:mc_options).permit(:options => [])
          options[:options].each do |option|
            @mc_question.mc_options << McOption.create(option: option)
          end

          render json: @mc_question
        else
          render json: {notice: "Failure! Could not save McQuestion due to #{@mc_question.errors.full_messages}"}
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
        @mc_question = McQuestion.find(params[:id])
      end
  end
