class AddUserTables < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :first_name
  		t.string :last_name
  		t.string :password_digest
  		t.string :city
  		t.string :state
  		t.string :email
  		t.string :user_type
  		t.text :bio
  		t.integer :boards_created
  		t.date :dob
  		t.timestamps
  	end

  	create_table :boards do |t|
  		t.string :title
  		t.text :description
  		t.string :theme
  		t.timestamps
  	end

  	create_table :events do |t|
  		t.integer :board_id
  		t.decimal :latitude
  		t.decimal :longitude
  		t.date :date
  		t.time :time
  		t.string :title
  		t.text :description
  		t.timestamps
  	end

  	create_table :photos do |t|
  		t.integer :event_id
  		t.string :url
  		t.string :description
  		t.timestamps
  	end
  end
end
