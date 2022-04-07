class Api::V1::SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  
  # GET /surveys or /surveys.json
  def index
    @surveys = Survey.all
    render json: @surveys
  end

  # GET /surveys/1 or /surveys/1.json
  def show

    if @survey.mc_questions.any? or @survey.text_questions.any?
      questions = @survey.mc_questions + @survey.text_questions
      sorted_questions = questions.sort_by(&:order)
      render json: {survey: @survey.as_json, questions: convert_question_to_json(sorted_questions).as_json}
    else
      render json: {survey: @survey.as_json}
    end
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys or /surveys.json
  def create
    begin
      @survey = Survey.new(survey_params_create)
    rescue ActionController::ParameterMissing => error
      render json: {error: error.message}
      return
    end

    if @survey.isLive
        @survey.wentLiveAt = DateTime.now()
    end

    if @survey.save
      render json: @survey
    else
      render json: @survey.errors
    end
  end

  # PATCH/PUT /surveys/1 or /surveys/1.json
  def update
    begin
      params = survey_params_update
      if @survey.closedOnDate
        return render json: {notice: 'Failure! Cannot update closed survey'}
      end

      if params[:isLive]
        params[:wentLiveAt] = DateTime.now()
      end

      if @survey.isLive & (params[:isLive] == "false" || params[:isLive] == false)
        params[:closedOnDate] = DateTime.now()
      end

      if @survey.update(params)
        render json: @survey
      else
        render json: {notice: "Failure! Could not save Survey due to #{@survey.errors.full_messages}"}
      end
    rescue ActionController::ParameterMissing => error
      render json: {error: error.message}
    end
  end

  # DELETE /surveys/1 or /surveys/1.json
  def destroy
    @survey.destroy

    render json: { notice: 'Survey was successfully removed.' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      begin
        @survey = Survey.find(params[:id])
      rescue ActiveRecord::ActiveRecordError => error
        render json: {error: error.message}
      end
    end

    # Only allow a list of trusted parameters through for the update method
    def survey_params_update
      params.require(:survey).permit(:title, :isLive)
    end

    # Only allow a list of trusted parameters through for the create method
    def survey_params_create
      params.require(:survey).permit(:title, :isLive).tap do |survey_params|
        survey_params.require(:title)
        survey_params.require(:isLive)
      end
    end

    # Converts a list of questions to json format
    def convert_question_to_json(questions)
      json_msg = []

      questions.each do |question|
        if question.is_a?(McQuestion)
          json_question = question.as_json(include: :mc_options)
          json_question[:question_type] = "mc"

          if question.mc_responses.any?
            mc_responses = question.mc_responses
            mc_options_id_map = question.mc_options.map{ |option| [option.id, option.option]}.to_h
            mc_option_count = mc_responses.group_by{|mc_response| mc_response.mc_option_id}.map{|mc_option_id, instances| [mc_options_id_map[mc_option_id], instances.count]}.to_h
            json_question[:mc_responses] = mc_option_count
          end

          json_msg.append(json_question)
        elsif question.is_a?(TextQuestion)
          json_question = question.as_json
          json_question[:question_type] = "text"

          if question.text_responses.any?
            text_responses = question.text_responses
            only_text = text_responses.map{|text_response| text_response.response}
            json_question[:text_responses] = only_text
          end

          json_msg.append(json_question)
        end
      end
      
      return json_msg
    end
end
