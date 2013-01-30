class CartItem < ActiveRecord::Base
  belongs_to :cart

  # attr_accessible :book_id, :book_inventory_id, :cart_id
end
