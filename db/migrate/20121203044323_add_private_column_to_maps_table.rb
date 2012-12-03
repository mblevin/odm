class AddPrivateColumnToMapsTable < ActiveRecord::Migration
  def change
    add_column :maps, :private, :boolean
  end
end