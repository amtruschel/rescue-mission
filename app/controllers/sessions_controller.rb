class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create

  def create
    @user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])

    if @user.valid?
      session[:user_id] = @user.id
      flash[:success] = "You are signed in as #{@user.username}!"
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    flash[:success] = "You have signed out"
    redirect_to root_path
  end

private
  def auth_hash
    request.env['omniauth.auth']
  end
end
