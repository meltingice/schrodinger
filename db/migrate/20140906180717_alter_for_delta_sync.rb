class AlterForDeltaSync < ActiveRecord::Migration
  def change
    remove_column :nodes, :dropbox_hash
    add_column :users, :last_cursor, :string
  end
end
