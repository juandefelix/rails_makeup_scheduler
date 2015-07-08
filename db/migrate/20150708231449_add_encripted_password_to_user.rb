class AddEncriptedPasswordToUser < ActiveRecord::Migration
  def up
    change_table(:users) do |t|
      t.string :email,              null: false, default: ""
    end
  end
end
