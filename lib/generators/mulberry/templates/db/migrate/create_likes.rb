class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, null: false
      t.references :likable, polymorphic: true, null: false
      t.integer :value, null: false

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, [:likable_type, :likable_id]
    add_index :likes, [:likable_type, :likable_id, :user_id], unique: true
  end
end
