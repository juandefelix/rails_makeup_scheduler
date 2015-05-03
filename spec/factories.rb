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
    provider 'facebook'
    password Devise.friendly_token[0, 20]
    uid '12345'

    # the :admin factory creates a User with the attributes expected in the test env. to sign in with facebook
    factory :admin do
      name 'Juan Ortiz'
      email 'juan@test.com'
      uid '1337'
      provider 'facebook'
      after(:create) {|user| user.add_role(:admin)}
    end
  end
end
