class AddHashToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :hash, :string
  end
end
