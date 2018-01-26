class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.text :content
      t.references :exercise, index: true, foreign_key: true

      t.timestamps
    end
  end
end
