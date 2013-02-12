class ChangeCartItems < ActiveRecord::Migration
  def change
    remove_column :cart_items, :book_id
    add_column    :cart_items, :quantity, :integer, null: false, default: 1
  end
end
