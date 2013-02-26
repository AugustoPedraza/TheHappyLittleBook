class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :book

  scope :find_by_book, lambda { |book_id| where(book_id: book_id) }

  default_scope order(:created_at)

  validates :cart, :book, presence: true

  attr_accessible :quantity, :price

  def subtotal
    price * quantity
  end

  def price
    book.current_price
  end

  def update_quantity(value)
    new_quantity = (value <= book.available_stock ? value : book.available_stock)
    update_attribute(:quantity, new_quantity)
  end

  #Funcionalidad movida al controller.
  # def available_quantity
  #   book_inventory.quantity
  # end

  #Tener en cuenta que, cuando cambio el precio de compra, tengo que
  #agregar un nuevo registro, copiando la informacion del ultimo, y poniendole
  #el precio nuevo.
end
