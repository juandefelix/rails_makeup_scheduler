FactoryGirl.define do
  factory :cancellation do
    name "Roberto Ruiz"
    instrument "Guitar"
    start_at "#{(Time.now + 1.day + 3.hours).strftime("%Y-%m-%d %H:%M")}"
    end_at "#{(Time.now + 1.day + 3.hours + 30.min).strftime("%Y-%m-%d %H:%M")}"
  end
end

