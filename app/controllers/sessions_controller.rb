class SessionsController < ApplicationController

  def new

  render :layout => 'login'
  end

  def create
    user = User.find(params[:id])
    session[:current_user_id] = user.id
  end

  def destroy
    session[:current_user_id] = nil
  end
end