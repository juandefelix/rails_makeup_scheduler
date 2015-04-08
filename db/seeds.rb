# Site admin user
User.create!(name: "Juan Ortiz",
             email: "juan@admin.com",
             password: "password",
             password_confirmation: "password").add_role(:admin)

# Bucktown music business
bucktown = Business.create!(name: "Bucktown Music",
                            email: "admin@bucktown.com",
                            city: "Chicago",
                            zip: "60657",
                            phone_number: "999-999-9999",
                            website: "wwww.bucktownmusic.com")

# Lincon Square music business
lincolnsq = Business.create!(name: "Lincoln Square Music",
                             email: "admin@lincolnsq.com",
                             city: "Chicago",
                             zip: "60658",
                             phone_number: "888-999-9999",
                             website: "wwww.lincolnsqmusic.com")

# Business admins
bucktown.users.create!(name: "Bucktown Admin",
                       email: "bucktown@admin.com",
                       password: "password",
                       password_confirmation: "password")

lincolnsq.users.create!(name: "Lincoln Sq Admin",
                        email: "lincolnsq@admin.com",
                        password: "password",
                        password_confirmation: "password")

# Students accounts
30.times do |n|
  bucktown_user = bucktown.users.create!(
    name: Faker::Name.name,
    email: "user-#{n}@bucktown.com",
    password: "password",
    password_confirmation: "password"
  )

  lincolnsq_user = lincolnsq.users.create!(
    name: Faker::Name.name,
    email: "user-#{n}@lincolnsq.com",
    password: "password",
    password_confirmation: "password"
  )
end

# Cancellations

INSTRUMENTS = ["Guitar", "Violin", "Bass"]
NOW = Time.now

# Cancellations
bucktown.users.each_with_index do |user, index|
  start_time = Time.new(NOW.year,
                        NOW.month,
                        NOW.day,
                        rand(9..20),
                        rand(0..1) * 30)
  start_time += rand(2..30).day

  # Non-taken cancellation
  user.created_cancellations.create!(
    name: user.name,
    instrument: INSTRUMENTS[rand(INSTRUMENTS.length)],
    start_at: start_time,
    end_at: start_time + rand(1..2).hour
  )

  # Taken cancellation
  user.created_cancellations.create!(
    name: user.name,
    instrument: INSTRUMENTS[rand(INSTRUMENTS.length)],
    start_at: start_time,
    end_at: start_time + rand(1..2).hour,
    taker: bucktown.users[-index -5]
  )
end

lincolnsq.users.each_with_index do |user, index|
  start_time = Time.new(NOW.year,
                        NOW.month,
                        NOW.day,
                        rand(9..20),
                        rand(0..1) * 30)
  start_time += rand(2..30).day

  # Non-taken cancellation
  user.created_cancellations.create!(
    name: user.name,
    instrument: INSTRUMENTS[rand(INSTRUMENTS.length)],
    start_at: start_time,
    end_at: start_time + rand(1..2).hour
  )

  # Taken cancellation
  user.created_cancellations.create!(
    name: user.name,
    instrument: INSTRUMENTS[rand(INSTRUMENTS.length)],
    start_at: start_time,
    end_at: start_time + rand(1..2).hour,
    taker: lincolnsq.users[-index -5]
  )
end
