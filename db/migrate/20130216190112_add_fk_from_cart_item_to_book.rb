class AddFkFromCartItemToBook < ActiveRecord::Migration
  def up
    remove_column :cart_items, :book_inventory_id
    add_column    :cart_items, :book_id, :integer, null: false
    add_column    :cart_items, :price, :decimal, null: false, precision: 8, scale: 2, default: 0
    add_foreign_key "cart_items", "books", name: "cart_items_books_id_fk", primary_key: "book_id"
  end

  def down
    add_column         :cart_items, :book_inventory_id, :integer
    remove_column      :cart_items, :book_id
  end
end
