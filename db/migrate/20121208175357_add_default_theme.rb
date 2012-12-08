class AddDefaultTheme < ActiveRecord::Migration
  def change
    change_column :maps, :theme, :string, :default => "default"
  end
end
