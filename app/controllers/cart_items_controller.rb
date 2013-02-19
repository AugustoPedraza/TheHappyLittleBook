class CartItemsController < InheritedResources::Base
  def create
    book = Book.find(params[:book_id])
    item = current_cart.cart_items.find_by_book(book.id).first

    unless item
      item = current_cart.cart_items.build(quantity: 1, price: book.current_price)
      item.book = book
      item.save!
    else
      item.update_column(:quantity, item.quantity + 1)
    end

    respond_to do |format|
      format.js
    end
  end
end
