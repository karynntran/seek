class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    binding.pry
    user = User.find_by({username: params[:username]})

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      session[:user_id] = nil
      redirect_to root_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end
end