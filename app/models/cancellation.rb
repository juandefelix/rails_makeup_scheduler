class Cancellation < ActiveRecord::Base
  
  belongs_to :creator, class_name: "User"
  belongs_to :taker, class_name: "User"

  default_scope -> { order('start_at DESC') }

  has_event_calendar 

  validates :start_at, format: { with: /20\d{2}[-\/][01]?\d[-\/][0-3]?\d [0-2]?\d:[0-5]?\d/i, 
                                 message: "must have the right format" }
  validates :name, :instrument, :start_at,:creator_id, presence: true

  with_options if: "start_at.present?" do |cancellation|
    cancellation.validate :in_the_past
    cancellation.validate :less_than_24
  end


  # Instance methods  

  def date_time_valid_format?
    self.start_at.to_s =~ /20\d{2}[-\/][01]?\d[-\/][0-3]?\d [0-2]?\d:[0-5]?\d/i
  end

  def in_the_past
    errors[:base]= "Date and time can not be in the past"     if self.start_at < Time.now
  end

  def less_than_24
    one_day_after = Time.now + 1.day
    errors[:base] = "Please, notify your absence within 24hr." if  start_at < one_day_after
  end

  def get_time
    self.start_at.strftime("%I:%M%p").gsub(/\A0/, "")
  end

  def get_date
    self.start_at.strftime("%m-%d-%y")
  end

  def available?
    !self.creator_id.nil? && self.taker_id.nil?
  end

  def creator_same_as(user)
    creator_id == user.id
  end
end
