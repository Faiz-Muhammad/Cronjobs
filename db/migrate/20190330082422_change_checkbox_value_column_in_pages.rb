class ChangeCheckboxValueColumnInPages < ActiveRecord::Migration[5.2]
  def change
    change_column :pages, :checkbox_value, :boolean, default: false
  end
end
