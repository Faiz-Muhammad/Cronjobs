class RemoveReferenceFromPostsAndPagesposts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :posts, :users, index: true
    remove_reference :pagesposts, :users, index: true
  end
end
