FactoryGirl.define do
  factory :cancellation do
    name "Roberto Ruiz"
    instrument "Guitar"
    date "#{(Time.now + 2.day).strftime("%m/%d/%y")}"
    start_time "20:30"
  end
end

