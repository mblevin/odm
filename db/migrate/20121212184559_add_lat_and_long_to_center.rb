class AddLatAndLongToCenter < ActiveRecord::Migration
  def change
    remove_column :maps, :geo_center
    add_column :maps, :geo_center_latitude, :decimal
    add_column :maps, :geo_center_longitude, :decimal
  end
end
