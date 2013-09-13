class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.string :name, :null => false
      t.text :description
      t.string :kind, :default => "#ffffff"
      t.integer :parent_id, :default => 0
      
      t.timestamps
    end
    add_index :catalogs, [:name], unique: true
  end
end