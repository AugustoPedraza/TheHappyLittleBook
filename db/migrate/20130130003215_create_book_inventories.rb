class CreateBookInventories < ActiveRecord::Migration
  def change
    create_table :book_inventories, primary_key: "book_inventory_id" do |t|
      t.decimal  :sale_price,        null: false, precision: 8, scale: 2
      t.integer  :quantity,          null: false, default: 0
      t.decimal  :purchase_price,    null: false, precision: 8, scale: 2
      t.integer  :solds_units,       null: false, default: 0
      t.integer  :purchased_units,   null: false
      t.integer  :book_id
      t.timestamps
    end

    add_index :book_inventories, :book_inventory_id
    add_foreign_key "book_inventories", "books", :name => "book_inventories_books_id_fk", :primary_key => "book_id"
  end
end
