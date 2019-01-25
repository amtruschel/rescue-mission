class ResponsesController < ApplicationController
  before_action :find_question, only: [:new,:create,:edit,:update,:destroy,:vote_for_answer,:vote_against_answer,:vote_for_best_answer]
  before_action :find_response, only: [:edit,:update,:destroy,:vote_for_answer,:vote_against_answer,:vote_for_best_answer]

  def show
    @response = Response.find(params[:response_id])
  end

  def new
    @response = Response.new
  end

  def edit
  end

  def update
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
    @response.destroy
    flash[:success] = "Your response has been deleted."
    redirect_to @question
  end

  def vote_for_answer
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

  def vote_for_best_answer
    if @response.best_answer.nil?
      @response.best_answer = true
    elsif @response.best_answer == true
      @response.best_answer = false
    else
      @response.best_answer = true
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

  def find_response
    @response = Response.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end
end
