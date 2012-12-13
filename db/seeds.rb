# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Map.delete_all
Event.delete_all


u1 = User.create(:username => "admin", :first_name => "Admin", :email => "dustin@dcoates.com", :password => "123!", :password_confirmation => "123!", :city => "Brooklyn", :state => "NY", :user_type => "admin", :bio => "I'm the original user.")
u2 = User.create(:username => "dustin", :first_name => "Dustin", :last_name => "Coates", :email => "dustin@dcoates.com", :password => "123!", :password_confirmation => "123!", :city => "Brooklyn", :state => "NY", :user_type => "admin", :bio => "I'm the original user.")
u3 = User.create(:username => "plus_user", :first_name => "Plus", :last_name => "User", :email => "dustin@dcoates.com", :password => "123!", :password_confirmation => "123!", :city => "Brooklyn", :state => "NY", :user_type => "plus", :bio => "I'm the original user.")
u2 = User.create(:username => "regular_user", :first_name => "Dustin", :last_name => "Coates", :email => "dustin@dcoates.com", :password => "123!", :password_confirmation => "123!", :city => "Brooklyn", :state => "NY", :user_type => "admin", :bio => "I'm the original user.")