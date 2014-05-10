class CreateCancellations < ActiveRecord::Migration
  def change
    create_table :cancellations do |t|
      t.string :name
      t.string :instrument
      t.string :date
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
