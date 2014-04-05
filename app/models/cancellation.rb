class Cancellation < ActiveRecord::Base
  validates :name, :instrument, :date, :start_time, :end_time, presence: true
  validates :start_time, :end_time, format: { with: /[0-1]?[1-9]:\d{2}\s*[pa]m/i, message: "Please follow this format: 'HH:MM pm' e.g. '01:30 pm" }
end
