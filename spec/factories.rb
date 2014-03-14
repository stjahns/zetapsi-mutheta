FactoryGirl.define do

  factory :member do
    name      "John Doe"
    email     "johndoe@example.com"
    password  "foobar"
    password_confirmation "foobar"
  end

  factory :event do
    name        "Tea Party"
    description "Drinking Tea"
    time        1.week.from_now
  end

end
