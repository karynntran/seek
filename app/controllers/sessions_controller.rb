class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    respond_to do |format|
      binding.pry
      user = User.find_by({username: params[:user][:username]})
      if user && user.authenticate(params[:user][:password])
        binding.pry
        session[:user_id] = user.id
        # redirect_to user_path(user)
        format.json { render json: {login: session[:user_id]} }
      else
        binding.pry
        session[:user_id] = nil
        # redirect_to root_path
        format.json { render json: {login: 'failed'} }
      end

    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end
end