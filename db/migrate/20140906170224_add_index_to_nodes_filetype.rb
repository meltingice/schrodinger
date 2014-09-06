class AddIndexToNodesFiletype < ActiveRecord::Migration
  def change
    add_index :nodes, :filetype
  end
end
