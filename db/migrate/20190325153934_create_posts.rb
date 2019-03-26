class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text      :description
      t.string    :link
      t.datetime  :start_time
      t.integer   :time_gap
      t.integer   :delete_time
      t.integer   :interval
      t.timestamps
    end
  end
end
