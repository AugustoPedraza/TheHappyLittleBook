class AddIsPurchaseColumnToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :is_purchase, :boolean, null: false, default: false
  end
end
