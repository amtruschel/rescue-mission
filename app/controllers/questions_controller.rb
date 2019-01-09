class QuestionsController < ApplicationController
  def index
    @recent_questions = Question.order(created_at: :desc).first(10)
  end

  def show
    @question = Question.find(params[:id])
  end
end
