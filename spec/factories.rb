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
    password '12341234'

    # the :admin factory creates a User with the attributes expected in the test env. to sign in with facebook
    factory :admin do
      name "Juan Ortiz"
      email 'juanadmin@example.com'
      provider 'facebook'
      uid '1337'
      password '12341234'
      after(:create) {|user| user.add_role(:admin)}
    end
  end
end

