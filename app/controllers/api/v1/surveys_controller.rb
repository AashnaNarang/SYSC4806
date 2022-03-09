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
    render json: @survey
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
    if !@survey.isLive
      begin
        params = survey_params_update
        if params[:isLive]
          params[:wentLiveAt] = DateTime.now()
        end

        if @survey.update(params)
          render json: @survey
        else
          render json: {notice: "Failure! Could not save Survey due to #{@survey.errors.full_messages}"}
        end
      rescue ActionController::ParameterMissing => error
        render json: {error: error.message}
      end
    else
      render json: {notice: 'Failure! Cannot update live survey'}
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
end
