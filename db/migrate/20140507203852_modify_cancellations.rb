class ModifyCancellations < ActiveRecord::Migration
  def self.up
    remove_column(:cancellations, :date)

    rename_column(:cancellations, :start_time, :start_at)
    change_column(:cancellations, :start_at, :datetime)

    add_column(:cancellations, :end_at, :datetime)
  end

  def self.down
    add_column(:cancellatinos, :date, :string)

    change_column(:cancellations, :start_at, :string)
    rename_column(:cancellations, :start_at, :start_time)

    remove_column(:cancellations, :end_at)
  end
end
