class MapsController < ApplicationController
  def show
  end
  def new
    @user = User.find(params[:user_id])
    @map = @user.maps.build
  end
  def create
    user = User.find(params[:user_id])
    map = Map.new(params[:map])
    map.user_id = user.id
    if map.save
      redirect_to new_user_map_event_path(user, map)
    else
      render :new
    end
  end
  def edit
    @map = Map.find(params[:id])
  end
  def destroy
  end
end