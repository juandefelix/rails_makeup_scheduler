class ModifyCancellations < ActiveRecord::Migration
  def self.up
    remove_column(:cancellations, :date)

    remove_column(:cancellations, :start_time)
    add_column(:cancellations, :start_at, :datetime)

    add_column(:cancellations, :end_at, :datetime)
  end

  def self.down
    add_column(:cancellatinos, :date, :string)

    remove_column(:cancellations, :start_at)
    add_column(:cancellations, :start_time, :string)

    remove_column(:cancellations, :end_at)
  end
end
