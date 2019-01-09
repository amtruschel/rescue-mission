class ResponsesController < ApplicationController
  def show
    @response = Response.find(params[:response_id])
  end

  def new
    @question = Question.find(params[:question_id])
    @response = Response.new
  end

  def create
    @question = Question.find(params[:id])
    @response = Response.new(response_params)

    if @response.save
      flash[:notice] = 'Response saved successfully'
      redirect_to @response
    else
      render :new
    end
    redirect_to @response
  end

private

  def response_params
    params.require(:response).permit(:body, :user_id)
  end
end
