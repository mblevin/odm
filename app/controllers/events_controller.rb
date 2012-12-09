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

  def find_place
    @place = params[:place].gsub(" ", "%20")
    @city = params[:city].gsub(" ", "%20")
    if @city.length != 0
      #Get locations near place if city specified. Limits to 10. Using a "browse" intent provides all venues with an area.
      @foursquare_results = HTTParty.get("https://api.foursquare.com/v2/venues/search?near=#{@city}&query=#{@place}&intent=browse&limit=10&client_id=#{FOURSQID}&client_secret=#{FOURSQSEC}&v=20121208")
    else
      #If no city was added, search globally.
      @foursquare_results = HTTParty.get("https://api.foursquare.com/v2/venues/search?&query=#{@place}&intent=global&limit=10&client_id=#{FOURSQID}&client_secret=#{FOURSQSEC}&v=20121208")
    end
    #For some reason we have to JSONify the JSONified?
    #I want to add in a fallback in case Foursquare is down.
    @foursquare_results = JSON(JSON(@foursquare_results))["response"]["venues"]

    render :json => @foursquare_results
  end

end