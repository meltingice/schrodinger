class AddUniqueIndexToAncestryAndName < ActiveRecord::Migration
  def change
    remove_index :nodes, :ancestry
    add_index :nodes, [:ancestry, :name], unique: true
  end
end
