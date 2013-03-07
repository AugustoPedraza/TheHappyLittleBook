class CreateSalaryConcepts < ActiveRecord::Migration
  def change
    create_table :salary_concepts, primary_key: "salary_concept_id" do |t|
      t.string   :description,  null: false
      t.integer  :cod,          null: false, uniqueness: true
      t.float    :percent,      null: false
      t.datetime :effect_since, null: false
      t.datetime :effect_to
      t.boolean  :gainful
      t.boolean  :deduction

      t.timestamps
    end

    add_column :pay_slip_items, :salary_concept_id, :integer
    add_index :pay_slip_items, :salary_concept_id
    add_foreign_key "pay_slip_items", "salary_concepts", name: "pay_slip_item_salary_concept_fk", primary_key: "salary_concept_id"
  end
end
