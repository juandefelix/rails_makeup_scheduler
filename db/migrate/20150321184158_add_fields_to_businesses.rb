class AddFieldsToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :city, :string
    add_column :businesses, :zip, :string
    add_column :businesses, :phone_number, :string
    add_column :businesses, :website, :string
  end
end
