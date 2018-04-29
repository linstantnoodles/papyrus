class CreateJoinTableTagging < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :taggable_id
      t.string :taggable_type
      t.index [:taggable_type, :tag_id, :taggable_id], name: 'tagging_index'
    end
  end
end
