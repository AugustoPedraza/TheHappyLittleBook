class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts, primary_key: "cart_id" do |t|
      t.integer :user_id
      t.decimal :calculated_total,        null: false, default: 0, precision: 8, scale: 2
      t.timestamps
    end

    add_column :users, :cart_id, :integer

    add_index :carts, :cart_id
    add_foreign_key "carts", "users", :name => "carts_users_id_fk", :primary_key => "user_id"
    add_foreign_key "users", "carts", :name => "users_carts_id_fk", :primary_key => "cart_id"
  end
end
