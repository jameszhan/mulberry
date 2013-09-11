class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.text :description
      t.string :group, default: "global"
      
      t.datetime :created_at
    end
    add_index :tags, [:name, :group], unique: true
  end
end