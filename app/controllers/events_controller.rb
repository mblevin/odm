class EventsController < ApplicationController
  def show
  end
  def new
    @event = Event.new
    @map = Map.find(params[:map_id])
    @user = User.find(params[:user_id])
    @existing_events = Event.where(:map_id => @map.id)
  end

  def edit
    @user = User.find(params[:user_id])
    @map = Map.find(params[:map_id])
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @map = Map.find(params[:map_id])
    @user = User.find(params[:user_id])
    if @event.update_attributes(params[:event])
      redirect_to user_map_path(@user, @map)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @map = Map.find(params[:map_id])
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_map_path(@user, @map)
  end

  def find_place
  end

  def get_place
    @place = params[:place].gsub(" ", "%20")
    @near = params[:near].gsub(" ", "%20")
    if @near.length != 0
      #Get locations near place if near place specified. Limits to 10. Using a "browse" intent provides all venues with an area.
      @foursquare_results = HTTParty.get("https://api.foursquare.com/v2/venues/search?near=#{@near}&query=#{@place}&intent=browse&limit=5&client_id=#{FOURSQID}&client_secret=#{FOURSQSEC}&v=20121208")
    else
      #If no near was added, search globally.
      @foursquare_results = HTTParty.get("https://api.foursquare.com/v2/venues/search?&query=#{@place}&intent=global&limit=5&client_id=#{FOURSQID}&client_secret=#{FOURSQSEC}&v=20121208")
    end
    #For some reason we have to JSONify the JSONified?
    #I want to add in a fallback in case Foursquare is down.
    @foursquare_results = JSON(JSON(@foursquare_results))["response"]["venues"]

    render :json => @foursquare_results
  end

  def save_event
    #Our year param is coming from a separate form field, so if they don't fill it out
    #we need to set a default.
    params[:year] = params[:event_date][:year] if params[:year] == ""
    @map = Map.find(params[:map_id])
    @user = User.find(@map.user_id)
    @event = Event.new(
      :title => params[:title],
      :description => params[:description],
      :date => Date.new(params[:year].to_i,
                              params[:event_date][:month].to_i,
                              params[:event_date][:day].to_i),
      :photo_url => params[:photo_url],
      :latitude => params[:latitude],
      :longitude => params[:longitude],
      :map_id => Map.find(params[:map_id]).id,
      :place_name => params[:place_name],
      :street_view_heading => params[:street_view_heading]
      )

    if @map.user_id != @authenticated_user.id
      @message = "You don't have permission to do that."
    end
    if @event.save
      @message = "Event saved."
      @events = Event.where(:map_id => @map.id)
    else
      @message = "Event not saved. Try again."
    end
  end

  def get_event
    map_id = Map.find(params[:map_id]).id
    events = Event.where(:map_id => map_id)
    @event_hash = {}

    events.each do |event|
      @event_hash[event.id] = event
    end
    binding.pry
    render :json => @event_hash
  end

end