class AddAccountReadyFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_ready, :boolean, default: false
  end
end
