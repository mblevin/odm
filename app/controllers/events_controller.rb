class EventsController < ApplicationController
  def show
  end
  def new
    @event = Event.new
    @map = Map.find(params[:map_id])
    @user = User.find(params[:user_id])
    @existing_events = Event.where(:map_id => @map.id)
  end
  def create
    map = Map.find(params[:map_id])
    event = Event.new(params[:event])
    event.map_id = map.id
    if event.save
      redirect_to root_path
    else
      render :new
    end
  end
  def edit

  end
  def destroy
  end
end