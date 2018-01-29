class AddStageToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :stage, :string
  end
end
