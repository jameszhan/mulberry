class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title, limit: 50, default: "" 
      t.text :content
      t.references :commentable, polymorphic: true
      t.references :user
      t.string :role, default: "comments"

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
