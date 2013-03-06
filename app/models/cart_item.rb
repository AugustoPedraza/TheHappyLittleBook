class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :book

  scope :find_by_book, lambda { |book_id| where(book_id: book_id) }

  default_scope order(:created_at)

  validates :book, presence: true

  attr_accessible :quantity, :price, :cart, :book, :book_id

  def subtotal
    price * quantity
  end

  def book_price
    book ? book.current_price : 0
  end

  def update_quantity(value)
    new_quantity = (value <= book.available_stock ? value : book.available_stock)
    update_attribute(:quantity, new_quantity)
  end

  #Register sale
  def update_available_stock
    book.update_inventory(quantity)
  end

  def update_stock_and_price
    book.update_inventory(quantity, price)
  end

  #Funcionalidad movida al controller.
  # def available_quantity
  #   book_inventory.quantity
  # end
end
