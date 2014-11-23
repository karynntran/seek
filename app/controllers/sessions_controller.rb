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
        # redirect_to user_path(user)
        format.json { render json: {status: 'created', username: user.username, id: user.id} }
      else
        session[:user_id] = nil
        # redirect_to root_path
        format.json { render json: {status: 'failed'} }
      end

    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end
end