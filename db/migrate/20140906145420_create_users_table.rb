class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.integer :dropbox_id
      t.string  :access_token
      t.text    :account
      t.timestamps
    end

    add_index :users, :dropbox_id, unique: true
  end
end
