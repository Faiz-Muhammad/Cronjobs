class AddStatusToPagesPost < ActiveRecord::Migration[5.2]
  def change
    add_column :pagesposts, :published_status, :boolean, :default =>false
  end
end
