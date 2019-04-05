class ChangeColumnsIntoPostsAndPagesposts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts,      :start_time, :datetime
    remove_column :posts,      :time_gap, :integer
    remove_column :posts,      :interval, :integer
    remove_column :posts,      :delete_time, :integer
    remove_column :pagesposts, :post_status, :string
    add_column    :pagesposts, :delete_post_time, :datetime
  end
end
