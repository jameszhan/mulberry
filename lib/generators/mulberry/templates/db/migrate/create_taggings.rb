class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :tag
      t.references :taggable, polymorphic: true
      t.references :tagger,   polymorphic: true

      t.datetime :created_at
    end
    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type]
    add_index :taggings, [:tagger_id, :tagger_type]
  end
end
