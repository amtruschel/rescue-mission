class QuestionsController < ApplicationController
  def index
    @recent_questions = Question.order(created_at: :desc).first(10)
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
    @responses = Response.where(question: @question).order(created_at: :asc)
    @response = Response.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params.merge(user_id: 1))

    if @question.save
      flash[:notice] = "Question saved successfully"
      redirect_to @question
    else
      flash[:notice] = @question.errors.full_messages.join(', ')
      redirect_to edit_question_path
    end
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
