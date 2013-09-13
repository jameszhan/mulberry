class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.float :score
      
      t.timestamps
    end
    add_index :rates, [:score], unique: true
  end
end
