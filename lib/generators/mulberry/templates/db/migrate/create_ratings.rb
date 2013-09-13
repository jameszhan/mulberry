class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :rate
      t.references :rater, polymorphic: true
      t.references :ratable, polymorphic: true
      
      t.text :review_text
      
      t.timestamps
    end
    
    add_index :ratings, :rate_id    
    add_index :ratings, [:ratable_id, :ratable_type]
  end
end
