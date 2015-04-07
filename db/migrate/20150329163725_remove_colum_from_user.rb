class RemoveColumFromUser < ActiveRecord::Migration
  def up
    remove_index :users, :reset_password_token
    remove_index :users, :confirmation_token

    remove_column :users, :reset_password_token, :string
    remove_column :users, :reset_password_token, :string
    remove_column :users, :reset_password_sent_at, :datetime
    remove_column :users, :remember_created_at, :datetime
    remove_column :users, :sign_in_count, :integer
    remove_column :users, :current_sign_in_at, :datetime
    remove_column :users, :last_sign_in_at, :datetime
    remove_column :users, :current_sign_in_ip, :string
    remove_column :users, :last_sign_in_ip, :string
    remove_column :users, :confirmation_token, :string
    remove_column :users, :confirmed_at, :datetime
    remove_column :users, :confirmation_sent_at, :datetime
  end

  def down
    add_column :users, :reset_password_token,   :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :remember_created_at,    :datetime
    add_column :users, :sign_in_count,          :integer, default: 0, null: false
    add_column :users, :current_sign_in_at,     :datetime
    add_column :users, :last_sign_in_at,        :datetime
    add_column :users, :current_sign_in_ip,     :string
    add_column :users, :last_sign_in_ip,        :string
    add_column :users, :confirmation_token,     :string
    add_column :users, :confirmed_at,           :datetime
    add_column :users, :confirmation_sent_at,   :datetime

    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
  end
end
