class RemoveEndTimeFromCancellations < ActiveRecord::Migration
  def change
    remove_column :cancellations, :end_time, :string
  end
end
