class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, null: false
      t.references :votable, polymorphic: true, null: false
      t.integer :value, null: false, default: 0

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, [:votable_type, :votable_id]
    add_index :votes, [:votable_type, :votable_id, :user_id], unique: true
  end
end
