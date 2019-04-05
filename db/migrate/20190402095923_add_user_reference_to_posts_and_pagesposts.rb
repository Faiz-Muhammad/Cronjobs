class AddUserReferenceToPostsAndPagesposts < ActiveRecord::Migration[5.2]
  def change
    add_reference :pagesposts, :user, index: true
    add_reference :posts, :user, index: true
  end
end
