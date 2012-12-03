class AddAtlasTable < ActiveRecord::Migration
  def change
    drop_table :boards
    create_table :maps do |t|
      t.string :title
      t.text :description
      t.string :theme
      t.integer :number_of_events
      t.timestamps
    end

    rename_column :events, :board_id, :map_id
    rename_column :users, :boards_created, :maps_created

    add_column :users, :profile_photo, :string

  end
end
