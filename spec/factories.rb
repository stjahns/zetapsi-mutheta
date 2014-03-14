FactoryGirl.define do

  factory :member do
    name      "John Doe"
    email     "johndoe@example.com"
    password  "foobar"
    password_confirmation "foobar"
  end

  factory :invitation do
    name      "John Doe"
    email     "johndoe@example.com"
  end

  factory :event do
    name        "Tea Party"
    description "Drinking Tea"
    time        1.week.from_now
  end

  factory :album do
    title        "Tea Party"
  end

end