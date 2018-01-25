class CreateParks < ActiveRecord::Migration[5.1]
  def change
  	create_table :parks do |t|
  		t.string :name
  		t.string :location
  		t.integer :owner_id
  	end
  end
end
