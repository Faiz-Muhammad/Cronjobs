class CreatePagesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :pages_tables do |t|
      create_table :pages do |t|
        t.string :page_name
        t.string :fb_page_id
        t.string :page_access_token
        t.text   :page_image
        t.belongs_to :user, index: true, foreign_key: true
        t.timestamps
      end
    end
  end
end
