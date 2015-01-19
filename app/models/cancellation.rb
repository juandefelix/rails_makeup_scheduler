class Cancellation < ActiveRecord::Base
  
  belongs_to :creator, class_name: "User"
  belongs_to :taker, class_name: "User"

  default_scope -> { order('start_at ASC') }

  has_event_calendar 

  validates_presence_of :name, :instrument, :start_at, :creator_id

  validates :start_at, format: { with: /20\d{2}[-\/][01]?\d[-\/][0-3]?\d [0-2]?\d:[0-5]?\d/i, 
                                 message: "must have the right format" }
  validate :in_the_past, if: "start_at.present?"
  validate :less_than_24, if: Proc.new { |c| c.start_at.present? && !c.in_the_past? }

  resourcify


  def self.by_day(year, month, day)
    date = DateTime.new(year, month, day)
    beginning_of_day = date.beginning_of_day
    end_of_day = date.end_of_day
    where("start_at >= ? and start_at <= ?", beginning_of_day, end_of_day)
  end

  # Instance methods  

  def date_time_valid_format?
    self.start_at.to_s =~ /20\d{2}[-\/][01]?\d[-\/][0-3]?\d [0-2]?\d:[0-5]?\d/i
  end

  def in_the_past
    errors[:base]= "Date and time can not be in the past" if self.start_at < Time.now
  end

  def in_the_past?
    self.start_at < Time.now
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
