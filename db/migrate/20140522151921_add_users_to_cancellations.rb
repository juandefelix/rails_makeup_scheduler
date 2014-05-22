class AddUsersToCancellations < ActiveRecord::Migration
  def change
    add_column :cancellations, :creator_id, :integer
    add_column :cancellations, :taker_id, :integer
  end
end
