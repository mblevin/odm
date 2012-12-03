class UsersController < ApplicationController
  def index
  end

  def show
  end

  def dashboard
  end

  def edit
    @user = User.find(params[:id])
    if session[:id] != params[:id]
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
      if @user.save
        session[:username] = @user.username
        session[:id] = @user[:id]
        redirect_to dashboard_path
      else
        render :new
      end
  end

  def destroy
    if session[:id] != params[:id]
      redirect_to users_path
    else
      user = User.find(params[:id])
      reset_session #Bad things happen if you don't reset the session.
      user.delete
      redirect_to root_path
    end
  end


end