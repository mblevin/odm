class AddStreetViewHeading < ActiveRecord::Migration
  def change
    add_column :events, :street_view_heading, :float, :default => 0
  end
end
