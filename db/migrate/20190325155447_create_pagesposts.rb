class CreatePagesposts < ActiveRecord::Migration[5.2]
  def change
    create_table :pagesposts do |t|
      t.belongs_to :page, index: true, foreign_key: true
      t.belongs_to :post, index: true, foreign_key: true
      t.string     :fb_post_id
      t.datetime   :scheduled_published_time
      t.string     :post_status  
      t.timestamps
    end
  end
end
