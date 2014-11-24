class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def check
    respond_to do |format|
      if current_user
        format.json { render json: { status: 'logged_in', username: current_user.username, id: current_user.id}}
      else
        format.json { render json: {status: 'failed'} }
      end
    end
  end

  def create
    respond_to do |format|
      user = User.find_by({username: params[:user][:username]})
      if user && user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        format.html { redirect_to user_path(user) }
        format.json { render json: {status: 'created', username: user.username, id: user.id} }
      else
        session[:user_id] = nil
        format.html { redirect_to root_path }
        format.json { render json: {status: 'failed'} }
      end

    end
  end

  def destroy
    binding.pry
    session[:user_id] = nil
    binding.pry
    redirect_to root_path
  end
end