class MapsController < ApplicationController
  def show
    @map = Map.find(params[:id])
    @map_events = Event.where(:map_id => @map.id).order('date ASC')
    @user = User.find(@map.user_id)
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
    @user = User.find(params[:user_id])
  end
  def destroy
  end
end