class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers, primary_key: "provider_id" do |t|
      t.string :name,     null: false
      t.string :cuit,     null: false, uniqueness: true
      t.string :address,  null: false

      t.timestamps
    end

    add_index :providers, :provider_id

    add_column :carts, :provider_id, :integer
    add_foreign_key "carts", "providers", name: "cart_provider_id_fk", primary_key: "provider_id"
  end
end
