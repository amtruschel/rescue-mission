class ResponsesController < ApplicationController
  before_action :find_question, only: [:new,:create,:edit,:update,:vote_for_answer,:vote_against_answer]

  def show
    @response = Response.find(params[:response_id])
  end

  def new
    @response = Response.new
  end

  def edit
    @response = Response.find(params[:id])
  end

  def update
    @response = Response.find(params[:id])
    @response.update(response_params.merge(user: current_user))
    binding.pry
    if @response.save
      flash[:success] = "Response saved successfully"
    else
      flash[:notice] = @response.errors.full_messages.join(', ')
    end
    redirect_to @question
  end

  def create
    @response = Response.new(response_params.merge({user: current_user, question: @question}))

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

  def vote_against_answer
    @response = Response.find(params[:id])

    if @response.ranking.nil?
      @response.ranking = -1
    else
      @response.ranking -= 1
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
end
