# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  map_id      :integer
#  latitude    :decimal(, )
#  longitude   :decimal(, )
#  date        :date
#  time        :time
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string(255)
#

class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
end
