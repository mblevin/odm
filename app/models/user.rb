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
  has_many :maps

  extend FriendlyId
  friendly_id :username, use: [:slugged, :history]

  has_secure_password
  validates :username, :first_name, :email, :presence => true
  validates :username, :uniqueness => true

  scope :admin, where(user_type: "admin")
  scope :partner, where(user_type: "partner")
end