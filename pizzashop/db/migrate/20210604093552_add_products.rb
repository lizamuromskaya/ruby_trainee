class AddProducts < ActiveRecord::Migration[6.1]
  def change

  	Product.create ({
  		:title => 'Hawaiian',
  		:description => 'This is Hawaiian pizza',
  		:price => 15,
  		:size => 30,
  		:is_spicy => false,
  		:is_veg => false,
  		:is_best_offer => false,
  		:path_to_image => '/images/hawaiian.jpg'
  		})

  	 Product.create ({
  		:title => 'Pepperoni',
  		:description => 'This is Pepperoni pizza',
  		:price => 14,
  		:size => 30,
  		:is_spicy => false,
  		:is_veg => false,
  		:is_best_offer => true,
  		:path_to_image => '/images/pepperoni.jpg'
  		})

  	Product.create ({
  		:title => 'Vegetarian',
  		:description => 'Amazing Vegetarian pizza',
  		:price => 14,
  		:size => 30,
  		:is_spicy => false,
  		:is_veg => true,
  		:is_best_offer => false,
  		:path_to_image => '/images/veg.jpg'
  		})
  end
end
