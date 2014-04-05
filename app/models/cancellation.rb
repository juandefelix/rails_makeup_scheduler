class Cancellation < ActiveRecord::Base
  validates :name, :instrument, :date, :start_time, :end_time, presence: true

end
