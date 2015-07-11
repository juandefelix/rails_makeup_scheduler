class AddEncriptedPasswordToUser < ActiveRecord::Migration
  def up
    change_table(:users) do |t|
      t.string :encrypted_password, null: false, default: ""
    end
  end
end
