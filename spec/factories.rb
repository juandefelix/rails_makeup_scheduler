FactoryGirl.define do
  factory :cancellation do
    name "Roberto Ruiz"
    instrument "Guitar"
    start_at "#{25.hours.from_now.strftime("%Y-%m-%d %H:%M")}"
    end_at   "#{26.hours.from_now.strftime("%Y-%m-%d %H:%M")}"
    association :creator, factory: :user
  end

  factory :user do
    sequence(:name)       { |n| "Person #{n}" }
    sequence(:email)      { |n| "person#{n}@example.com" }
    password              "foobar"
    password_confirmation "foobar"
  end
end

