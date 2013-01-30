class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers, primary_key: "publisher_id" do |t|
      t.string :name
      t.timestamps
    end
    
    add_index :publishers, :publisher_id
    add_foreign_key "books", "publishers", :name => "books_publishers_id_fk", :primary_key => "publisher_id"
  end
end
