class CartItemsController < InheritedResources::Base
  def create
    book_inventory = BookInventory.find(params[:book_inventory_id])
    item       = current_cart.cart_items.find_by_book_inventory(book_inventory.id).first

    unless item
      item = current_cart.cart_items.build(quantity: 1)
      item.book_inventory = book_inventory
      item.save!
    else
      item.update_column(:quantity, item.quantity + 1)
    end

    respond_to do |format|
      format.js
    end
  end
end
