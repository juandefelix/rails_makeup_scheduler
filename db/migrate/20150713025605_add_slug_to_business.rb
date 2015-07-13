class AddSlugToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :slug, :string
    add_column :businesses, :string, :string
  end
end
