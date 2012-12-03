class AddSlugs < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_index :users, :slug

    add_column :maps, :slug, :string
    add_index :maps, :slug

    add_column :events, :slug, :string
    add_index :events, :slug
  end
end
