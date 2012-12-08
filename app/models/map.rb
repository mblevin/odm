# == Schema Information
#
# Table name: maps
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :text
#  theme            :string(255)      default("default")
#  number_of_events :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  slug             :string(255)
#  private          :boolean
#  user_id          :integer
#

class Map < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  validates :title, :description, :presence => true

  belongs_to :user
  has_many :events
end
