class AddGeoCenter < ActiveRecord::Migration
  def change
    add_column :maps, :geo_center, :decimal
  end
end
