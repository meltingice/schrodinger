class ChangeNodeHashToDropboxHash < ActiveRecord::Migration
  def change
    rename_column :nodes, :hash, :dropbox_hash
  end
end
