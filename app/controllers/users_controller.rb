class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @maps = Map.where(:user_id => @user.id)
    if request.path != user_path(@user)
      redirect_to @user, status: :moved_permanently
    end
  end

  def dashboard
  end

  def edit
    @user = User.find(params[:id])
    if @authenticated_user.user_type != "admin" && @authenticated_user != @user
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
    if @authenticated_user && @authenticated_user.user_type != "admin"
      redirect_to root_path
    end
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
    if User.find(params[:id]) != @authenticated_user && @authenticated_user.user_type != "admin"
      redirect_to users_path
    else
      user = User.find(params[:id])
      reset_session #Bad things happen if you don't reset the session.
      user.delete
      redirect_to root_path
    end
  end
end