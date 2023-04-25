# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  # GET /questions or /questions.json
  def index
    @questions = if params[:all_messages].present?
                   Question.all.order(created_at: :desc)
                 else
                   Question.all.order(created_at: :desc).limit(100)
                 end
    @question = Question.new
  end

  # GET /questions/1 or /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    response = Openai.new.question(question_params['text'])
    @question = Question.new(question_params)

    if @question.save!
      @question.update!(response:)
      redirect_back fallback_location: questions_path
    else
      redirect_back fallback_location: questions_path, notice: 'Something went wrong'
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html do
          redirect_to question_url(@question), notice: 'Question was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def question_params
    params.require(:question).permit(:text, :response)
  end
end
