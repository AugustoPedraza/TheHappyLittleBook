class CreateFamilyGroups < ActiveRecord::Migration
  def change
    create_table :family_groups, primary_key: "family_group_id" do |t|
      t.string   :first_name,     null: false
      t.string   :last_name,      null: false
      t.string   :cuil,           null: false, uniqueness: true
      t.datetime :birth_date,     null: false
      t.boolean  :is_son,         default: false
      t.integer  :employee_id

      t.timestamps
    end

    add_index :family_groups, :employee_id
    add_foreign_key "family_groups", "employees", name: "family_group_employee_id_fk", primary_key: "employee_id"
  end
end
