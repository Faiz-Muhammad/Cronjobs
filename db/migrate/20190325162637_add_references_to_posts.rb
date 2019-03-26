class AddReferencesToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :user_id, :integer, foreign_key: true
  end
end
