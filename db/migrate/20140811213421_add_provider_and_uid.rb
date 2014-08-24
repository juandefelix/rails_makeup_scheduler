class AddProviderAndUid < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.remove :password_digest
      t.string :provider
      t.string :uid
    end
  end

  def down
    change_table :users do |t|
      t.remove :uid
      t.remove :provider
      t.string :password_digest
    end
  end
end
