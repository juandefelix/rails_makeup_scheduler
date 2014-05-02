require 'pry'

class Cancellation < ActiveRecord::Base
  validates :name, :instrument, :date, :start_time, presence: true
  validates :start_time, format: { with: /[0-1][0-9]:\d{2}/i, message: "must follow this format: '(H)H:MM pm' e.g. '01:30 pm, 2:30pm'" }
  validates :date, format: { with: /\A[01]?[0-9][-\/][0123]?[0-9][-\/](20)?[0-9]{2}\z/, message: "Invalid date format" }
  validate :cannot_be_in_the_past
  validate :less_than_24

  def date_and_time
    date_and_time = self.date + " " + self.start_time
    date_and_time_array = date_and_time.split(/[\D]/)

    year = "20" + date_and_time_array[2]
    month = date_and_time_array[0]
    day = date_and_time_array[1]
    hour = date_and_time_array[3]
    minute = date_and_time_array[4]

    Time.new(year, month, day, hour, minute)
  end

  def cannot_be_in_the_past
    
    errors[:base] << "The date and time can not be in the past" if date_and_time < Time.now
  end

  def less_than_24
    one_day_after = Time.now + 1.day
    # binding.pry
    errors[:base] << "Please, notify your absence within 24hr." if  date_and_time < one_day_after
  end
end
