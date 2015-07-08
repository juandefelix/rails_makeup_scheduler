class AddRememberCreatedAtToUsers < ActiveRecord::Migration
  def up
    change_table(:users) do |t|
      t.datetime :remember_created_at
    end
  end
end
