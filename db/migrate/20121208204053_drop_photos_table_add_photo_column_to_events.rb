class DropPhotosTableAddPhotoColumnToEvents < ActiveRecord::Migration
  def change
    drop_table :photos
    add_column :events, :photo_url, :string
  end
end
