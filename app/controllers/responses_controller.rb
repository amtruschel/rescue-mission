class ResponsesController < ApplicationController
  def show
    @response = Response.find(params[:response_id])
  end

  def new
    @question = Question.find(params[:question_id])
    @response = Response.new
  end

  def create
    @question = Question.find(params[:question_id])
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
  end

private

  def response_params
    params.require(:response).permit(:body, :user_id, :question_id)
  end

  def current_user
    @current_user ||= User.find(id: session[:user_id])
  end
end
