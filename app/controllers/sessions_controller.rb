class SessionsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]
  layout 'responsive'
  
  def new
  end

  def create
    learner = Learner.find_by_email(params[:email])
    if learner && learner.authenticate(params[:password])
      session[:learner_id] = learner.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:learner_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end  
end
