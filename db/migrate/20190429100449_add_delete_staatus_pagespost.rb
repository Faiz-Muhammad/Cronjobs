class AddDeleteStaatusPagespost < ActiveRecord::Migration[5.2]
  def change
    add_column :pagesposts, :deleted_status, :boolean, :default =>false
  end
end
