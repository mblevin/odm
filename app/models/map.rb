# == Schema Information
#
# Table name: maps
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :text
#  theme            :string(255)
#  number_of_events :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  slug             :string(255)
#

class Map < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  validates :title, :description, :theme, :presence => true

  belongs_to :user
  has_many :events
end
