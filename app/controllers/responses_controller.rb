class ResponsesController < ApplicationController
  before_action :find_question, only: [:new,:create,:vote_for_answer]

  def show
    @response = Response.find(params[:response_id])
  end

  def new
    @response = Response.new
  end

  def create
    @response = Response.new(response_params.merge({user_id: 1, question: @question}))

    if @response.save
      flash[:success] = 'Response saved successfully'
    else
      flash[:notice] = @response.errors.full_messages.join(', ').gsub('Body','Response')
    end
    redirect_to question_path(@question)
  end

  def destroy

  end

  def vote_for_answer
    @response = Response.find(params[:id])

    if @response.ranking.nil?
      @response.ranking = 1
    else
      @response.ranking += 1
    end

    if @response.save
      flash[:success] = "Thanks for voting!"
      redirect_to @question
    else
      flash[:notice] = "Something went wrong :("
      redirect_to @question
    end
  end

private

  def response_params
    params.require(:response).permit(:body, :user_id, :question_id)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def current_user
    @current_user ||= User.find(id: session[:user_id])
  end
end
