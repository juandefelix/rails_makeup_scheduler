class AddBusinessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :business_id, :integer
  end
end
