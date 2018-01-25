class CreatePets < ActiveRecord::Migration[5.1]
  def change
  	create_table :pets do |t|
  		t.string :name
  		t.string :color
  		t.string :age
  		t.integer :owner_id
  		t.integer :park_id
  	end
  end
end
