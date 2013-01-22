class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors, primary_key: "author_id" do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end

    add_index :authors, [:last_name, :first_name], unique: true
  end
end
