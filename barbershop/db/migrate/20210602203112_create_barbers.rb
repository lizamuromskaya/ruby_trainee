class CreateBarbers < ActiveRecord::Migration[6.1]
  def change
  	create_table :barbers do |t|
  		t.string :name

  		t.timestamps #added created_at and updated_at
  	end

  	Barber.create :name => "Ann"
  	Barber.create :name => "Jull"
  	Barber.create :name => "Mike"

  end
end
