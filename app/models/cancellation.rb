require 'pry'

class Cancellation < ActiveRecord::Base
    # binding.pry
  has_event_calendar 

  validates :start_at, format: { with: /20\d{2}[-\/][01]?\d[-\/][0-3]?\d [0-2]?\d:[0-5]?\d/i, 
                                 message: "must have the right format" }, unless: 'start_at.blank?'
  validates :name, :instrument, :start_at, presence: true
  

  # if they date and time have valid format, apply the other two validations 
  with_options if: :date_time_valid_format? do |cancellation|
    cancellation.validate :in_the_past
    cancellation.validate :less_than_24
  end


  def date_and_time
    date_and_time_array = self.start_at.to_s.split(/\D/)

    year = date_and_time_array[0].blank? ? "2000" : date_and_time_array[0]
    month = date_and_time_array[1].blank? ? "01" : date_and_time_array[1]
    day = date_and_time_array[2].blank? ? "01" : date_and_time_array[2]
    hour = date_and_time_array[3]  || "12"
    minute = date_and_time_array[4]  || "00"
    Time.new(year, month, day, hour, minute)
  end

  def date_time_valid_format?
    self.start_at.to_s =~ /20\d{2}[-\/][01]?\d[-\/][0-3]?\d [0-2]?\d:[0-5]?\d/i
  end

  def in_the_past
    errors[:base] << "The date and time can not be in the past" if date_and_time < Time.now
  end

  def less_than_24
    one_day_after = Time.now + 1.day
    
    errors[:base] << "Please, notify your absence within 24hr." if  date_and_time < one_day_after
  end
end
