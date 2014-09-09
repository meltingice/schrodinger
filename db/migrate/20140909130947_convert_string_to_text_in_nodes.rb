class ConvertStringToTextInNodes < ActiveRecord::Migration
  def change
    change_column :nodes, :dropbox_path, :text
  end
end
