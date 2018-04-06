class CreateComments < ActiveRecord::Migration[5.1]
  def change
  	create_table :comments do |t|
  		t.string :title
  		t.string :content
  		t.integer :owner_id
  		t.integer :pet_id
  	end
  end
end
