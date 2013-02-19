class BookInventory < ActiveRecord::Base
  belongs_to :book

  attr_accessible :sale_price, :solds_units, :purchase_price, :purchased_units,:quantity

  # default_scope where("quantity > 0").order("created_at ASC")

  # Example...
  # scope :with_stock :published, where(:published => true)

end
