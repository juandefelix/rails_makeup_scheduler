FactoryGirl.define do
  factory :cancellation do
    name "Roberto Ruiz"
    instrument "Guitar"
    start_at "#{(Time.now + 1.day + 3.hours).strftime("%Y-%m-%d %H:%M")}"
    end_at "#{(Time.now + 1.day + 3.hours + 30.minutes).strftime("%Y-%m-%d %H:%M")}"
  end

  factory :user do
    name                  "Example User"
    email                 "user@example.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end

