class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :dropbox_id
      t.string  :ancestry
      t.string  :name
      t.integer :size
      t.string  :filetype
      t.timestamps
    end

    add_index :nodes, :ancestry
  end
end
