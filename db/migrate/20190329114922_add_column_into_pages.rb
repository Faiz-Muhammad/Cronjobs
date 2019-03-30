class AddColumnIntoPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :checkbox_value, :boolean, default: true
  end
end
