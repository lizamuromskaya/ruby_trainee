class CreateClients < ActiveRecord::Migration[6.1]
  def change
  	create_table :clients do |t|
  		t.string :name
  		t.string :phone
     	t.string :datestamp
  		t.string :barber
  		t.string :color

  		t.timestamps #added created_at and updated_at
  	end
  end
end
