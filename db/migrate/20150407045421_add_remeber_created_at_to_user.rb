class AddRemeberCreatedAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :remember_created_at, :datetime
  end
end
