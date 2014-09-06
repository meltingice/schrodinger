class AddPathToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :path, :string
  end
end
