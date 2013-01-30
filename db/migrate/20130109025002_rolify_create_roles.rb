class RolifyCreateRoles < ActiveRecord::Migration
  def change
    create_table(:roles, primary_key: "role_id") do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:users_roles, [ :user_id, :role_id ])
    add_foreign_key "users_roles", "roles", :name => "users_roles_role_id_fk", :primary_key => "role_id"
    add_foreign_key "users_roles", "users", :name => "users_roles_user_id_fk", :primary_key => "user_id"
  end
end
