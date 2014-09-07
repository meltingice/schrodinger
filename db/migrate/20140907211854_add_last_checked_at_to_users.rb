class AddLastCheckedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_checked_at, :datetime
  end
end
