class BookInventory < ActiveRecord::Base
  belongs_to :book

  attr_accessible :sale_price, :solds_units, :purchase_price, :purchased_units,:quantity

  # default_scope where("quantity > 0").order("created_at ASC")

  # Example...
  # scope :with_stock :published, where(:published => true)

  #Tener en cuenta que, cuando cambio el precio de compra, tengo que
  #agregar un nuevo registro, copiando la informacion del ultimo, y poniendole
  #el precio nuevo.

  def update_stock(type, new_quantity)

    case type
    when :sales
      self.quantity        -= new_quantity
      self.solds_units     += new_quantity
    when :purchase
      self.quantity        += new_quantity
      self.purchased_units += new_quantity
    else
      puts "="*50
      puts "ERROR"
      puts "="*50
      raise "mala actualizacion"
    end

    save!
  end
end
