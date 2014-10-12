FactoryGirl.define do
  factory :cancellation do
    name Faker::Name.name
    instrument ["Guitar", "Piano", "Voice", "Clarinet", "Drums"].sample
    start_at "#{25.hours.from_now.strftime("%Y-%m-%d %H:%M")}"
    end_at   "#{26.hours.from_now.strftime("%Y-%m-%d %H:%M")}"
    association :creator, factory: :user
  end

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    sequence(:uid)   { |n| "#{n}" }
    provider "facebook"
  end
end

