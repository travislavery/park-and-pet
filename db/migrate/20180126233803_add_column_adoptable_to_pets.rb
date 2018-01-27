class AddColumnAdoptableToPets < ActiveRecord::Migration[5.1]
  def change
  	add_column :pets, :adoptable, :boolean, default: false
  end
end
