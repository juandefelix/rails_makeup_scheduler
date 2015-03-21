class RemovePasswordDigestFromBusinesses < ActiveRecord::Migration
  def change
    remove_column :businesses, :password_digest, :string
  end
end
