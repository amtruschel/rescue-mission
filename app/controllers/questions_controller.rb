class QuestionsController < ApplicationController
  def index
    @recent_questions = Question.order(created_at: :desc).first(10)
  end

  def show
    @question = Question.find(params[:id])
    @responses = Response.where(question: @question)
    @response = Response.new
  end

  def create
    @question = Question.new(question_params.merge(user: current_user))

    if @question.save
      flash[:notice] = "Question saved successfully"
    else
      render :new
    end
    redirect_to @question
  end

private

  def question_params
    params.require(:question).permit(:title, :description, :user_id)
  end

end
