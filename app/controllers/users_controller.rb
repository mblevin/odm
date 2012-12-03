class UsersController < ApplicationController
  def index
  end

  def show
  end

  def dashboard
  end

  def edit
  end

  def update
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

  end


end