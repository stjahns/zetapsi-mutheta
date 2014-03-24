FactoryGirl.define do

  factory :member do
    name                  "John Doe"
    email                 "johndoe@example.com"
    password              "foobar123"
    password_confirmation "foobar123"
    confirmed_at          DateTime.now
  end

  factory :event do
    name        "Tea Party"
    description "Drinking Tea"
    start_time  1.week.from_now
    has_end     true
    end_time    1.week.from_now + 1.hour
  end

  factory :album do
    title        "Tea Party"
  end

end
