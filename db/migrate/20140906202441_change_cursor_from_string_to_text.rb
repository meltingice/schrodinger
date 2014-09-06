class ChangeCursorFromStringToText < ActiveRecord::Migration
  def change
    change_column :users, :last_cursor, :text
  end
end
