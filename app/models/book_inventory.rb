class BookInventory < ActiveRecord::Base
  belongs_to :book

  attr_accessible :sale_price, :quantity, :purchase_price,
                  :solds_units, :purchased_units

  default_scope where("quantity > 0").order("created_at ASC")
end
