class AddPostToPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :post, foreign_key: true
  end
end
