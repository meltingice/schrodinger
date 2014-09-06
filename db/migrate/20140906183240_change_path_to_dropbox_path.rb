class ChangePathToDropboxPath < ActiveRecord::Migration
  def change
    rename_column :nodes, :path, :dropbox_path
  end
end
