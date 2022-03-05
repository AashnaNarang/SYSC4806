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
    @survey = Survey.new(survey_params)
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
    @survey.update(survey_params)
    if @survey.isLive
      @survey.wentLiveAt = DateTime.now()
    end
    if @survey.save
      render json: @survey
    else
      render json: @survey.errors
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
      @survey = Survey.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def survey_params
      params.require(:survey).permit(:title, :isLive)
    end
end
