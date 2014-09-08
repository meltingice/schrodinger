class ConvertSizeToBigint < ActiveRecord::Migration
  def change
    change_column :nodes, :size, :integer, limit: 8
  end
end
