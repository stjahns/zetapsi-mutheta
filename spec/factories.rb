FactoryGirl.define do
  factory :member do
    name      "John Doe"
    email     "johndoe@example.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end
