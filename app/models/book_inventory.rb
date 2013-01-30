class BookInventory < ActiveRecord::Base
  belongs_to :book

  attr_accessible :sale_price, :quantity, :purchase_price,
                  :solds_units, :purchased_units

end
