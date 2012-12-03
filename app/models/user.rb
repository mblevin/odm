# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  password_digest :string(255)
#  city            :string(255)
#  state           :string(255)
#  email           :string(255)
#  user_type       :string(255)
#  bio             :text
#  maps_created    :integer
#  dob             :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  profile_photo   :string(255)
#  slug            :string(255)
#

class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: [:slugged, :history]
end
