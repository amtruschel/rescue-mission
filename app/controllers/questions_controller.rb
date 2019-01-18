class QuestionsController < ApplicationController
  before_action :find_question, only: [:show,:edit,:update,:destroy]

  def index
    @recent_questions = Question.order(created_at: :desc).first(10)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params.merge(user_id: 1))

    if @question.save
      flash[:success] = "Question saved successfully"
    else
      render :new
    end
    redirect_to @question
  end

  def show
    renderer = Redcarpet::Render::HTML.new({ filter_html: true, hard_wrap: true })
    @markdown = Redcarpet::Markdown.new(renderer, extensions = {
      fenced_code_blocks: true,
      autolink: true,
      space_after_headers: false,
      strikethrough: true,
      superscript: true,
      quote: true,
      highlight: true,
      underline: false,
      footnotes: true  })
    @responses = Response.where(question: @question).order(created_at: :asc)
    @response = Response.new
  end

  def edit
  end

  def update
    @question.update(question_params.merge(user_id: 1))

    if @question.save
      flash[:success] = "Question saved successfully"
      redirect_to @question
    else
      flash[:notice] = @question.errors.full_messages.join(', ')
      redirect_to edit_question_path
    end
  end

  def destroy
    @responses = Response.where(question: @question)
    @responses.destroy_all
    @question.destroy
    flash[:success] = "Your question has been deleted."
    redirect_to root_path
  end

private

  def question_params
    params.require(:question).permit(:title, :description, :user_id)
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def current_user
    @current_user ||= User.find(id: session[:user_id])
  end

end
