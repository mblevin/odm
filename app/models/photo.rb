# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  event_id    :integer
#  url         :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Photo < ActiveRecord::Base

end
