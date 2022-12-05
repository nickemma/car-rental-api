FactoryBot.define do
  factory :user do
    name { Faker::Lorem.word }
    email { Faker::Lorem.word }
    password { '12qcd345gth' }
    admin { true }
    date_of_birth { '1999-02-22' }
  end

  factory :car do
    name { Faker::Lorem.word }
    description { Faker::Lorem.word }
    brand { Faker::Lorem.word }
    daily_rate { '123' }
    car_type { Faker::Lorem.word }
  end
end
