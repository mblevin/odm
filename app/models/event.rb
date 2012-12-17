# == Schema Information
#
# Table name: events
#
#  id                  :integer          not null, primary key
#  map_id              :integer
#  latitude            :decimal(, )
#  longitude           :decimal(, )
#  date                :date
#  time                :time
#  title               :string(255)
#  description         :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  slug                :string(255)
#  photo_url           :string(255)
#  place_name          :string(255)
#  street_view_heading :float            default(0.0)
#

class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  mount_uploader :photo_url, PhotoUploader

  belongs_to :map

  after_save :set_center
  after_update :set_center

  def set_center
    map_events = Event.where(:map_id => self.map_id)
    current_map = Map.find(self.map_id)
    map_points = map_events.collect{|map_event| [map_event.latitude, map_event.longitude]}
    geo_center = Geocoder::Calculations.geographic_center(map_points)
    current_map.update_attributes(:geo_center_latitude => geo_center[0]) if geo_center[0]
    current_map.update_attributes(:geo_center_longitude => geo_center[1]) if geo_center[1]

    current_map.save
  end
end
