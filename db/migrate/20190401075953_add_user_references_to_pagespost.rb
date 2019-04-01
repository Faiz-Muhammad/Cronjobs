class AddUserReferencesToPagespost < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :pagesposts, index: true
  end
end
