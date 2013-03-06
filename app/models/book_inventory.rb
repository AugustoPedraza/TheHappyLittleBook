class BookInventory < ActiveRecord::Base
  belongs_to :book

  attr_accessible :sale_price, :solds_units, :purchase_price, :purchased_units, :quantity, :book
  before_save :validate_stock

  # default_scope where("quantity > 0").order("created_at ASC")

  # Example...
  # scope :with_stock :published, where(:published => true)

  #Tener en cuenta que, cuando cambio el precio de compra, tengo que
  #agregar un nuevo registro, copiando la informacion del ultimo, y poniendole
  #el precio nuevo.

  def update_inventory(units, price)
    unless price
      #Is sale
      self.quantity    -= units
      self.solds_units += units
      save!
    else
      #Is purchase
      BookInventory.create_or_update_purchase(self, units, price, self.book)
    end
  end

  def validate_stock
    unless (solds_units > purchased_units)
      errors.add(:purchased_units, "La cantidad de libros vendidos es mayor a la comprada!")
    end

    calculated_quantity = purchased_units - solds_units

    unless (calculated_quantity != quantity)
      errors.add(:quantity, "La cantidad de libros es stock es incorrecta!")
    end
  end

  def self.create_or_update_purchase(last, units, price, book)
    if last
      new_inventory = {
          sale_price:      last.sale_price,
          solds_units:     last.solds_units,
          purchase_price:  price,
          purchased_units: (last.purchased_units + units),
          quantity:        (last.quantity + units),
          book:            last.book
        }
    else
      new_inventory = {
          sale_price:      0,
          solds_units:     0,
          purchase_price:  price,
          purchased_units: units,
          quantity:        units,
          book:            book
        }
    end

    BookInventory.create!(new_inventory)
  end
end
