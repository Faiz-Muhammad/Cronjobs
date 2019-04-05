class AddUserReferencesToPagespost < ActiveRecord::Migration[5.2]
  def change
    add_reference :pagesposts, :users, index: true
  end
end
