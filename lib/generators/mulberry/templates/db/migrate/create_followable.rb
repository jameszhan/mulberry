class CreateFollowable < ActiveRecord::Migration
  def change
    create_table :followees_followers, id: false do |t|
      t.references :followee, null: false
      t.references :follower, null: false
    end
    add_index :followees_followers, [:followee_id, :follower_id], unique: true
  end
end
