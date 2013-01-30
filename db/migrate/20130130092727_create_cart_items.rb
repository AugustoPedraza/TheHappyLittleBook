class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items, primary_key: "cart_item_id" do |t|
      t.integer :book_id
      t.integer :book_inventory_id
      t.integer :cart_id

      t.timestamps
    end

    add_index :cart_items, :cart_item_id
    add_foreign_key "cart_items", "books", :name => "cart_items_books_id_fk", :primary_key => "book_id"
    add_foreign_key "cart_items", "book_inventories", :name => "cart_items_book_inventories_id_fk", :primary_key => "book_inventory_id"
    add_foreign_key "cart_items", "carts", :name => "cart_items_carts_id_fk", :primary_key => "cart_id"
  end
end
