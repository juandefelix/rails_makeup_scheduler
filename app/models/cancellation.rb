class Cancellation < ActiveRecord::Base
  validates :name, :instrument, :date, :start_time, presence: true
  validates :start_time, format: { with: /[0-1]?[1-9]:\d{2}\s*[pa]m/i, message: "must follow this format: 'HH:MM pm' e.g. '01:30 pm, 2:30pm'" }
  validates :date, format: { with: /\A[01]?[0-9]{1}[-\/][012]?[0-9]{1}[-\/](20)?[0-9]{2}\z/, message: "Invalid date format" }
end
