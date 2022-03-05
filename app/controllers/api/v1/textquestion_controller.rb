class Api::V1::TextquestionController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /textquestion/1/edit
  def edit
  end

  # POST /textquestion or /textquestion.json
  def create
    @textquestion = TextQuestion.new(question_params)

    if @textquestion.save
      render json: @textquestion
    else
      render json: @textquestion.errors
    end
  end

  # PATCH/PUT /textquestion/1 or /textquestion/1.json
  def update
    @textquestion.update(question_params)

    if @textquestion.save
      render json: @textquestion
    else
      render json: @textquestion.errors
    end
  end

  # DELETE /textquestion/1 or /textquestion/1.json
  def destroy
    @textquestion.destroy

    render json: { notice: 'Survey was successfully removed.' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @textquestion = TextQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:textquestion).permit(:question, :survey_id)
    end
end
