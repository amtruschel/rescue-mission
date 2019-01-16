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
      flash[:notice] = 'Response saved successfully'
    else
      flash[:notice] = @response.errors.full_messages.join(', ').gsub('Body','Response')
    end
    redirect_to question_path(@question)
  end

private

  def response_params
    params.require(:response).permit(:body, :user_id, :question_id)
  end
end
