class RemoveIndexFromUsers < ActiveRecord::Migration
  def up
    remove_index :users, :remember_token
  end

  def down
    add_index :users, :remember_token
  end
end
