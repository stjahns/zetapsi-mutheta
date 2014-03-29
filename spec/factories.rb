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

  factory :reimbursement_request do
    description   "request"
    amount        100
    receipt       { File.new(Rails.root.join('app', 'assets', 'images', 'FratCoverPic.jpg')) }
  end

  factory :reimbursement do
    description   "reimbursement"
    amount        100
  end

  factory :charge do
    description   "charge"
    amount        100
  end

  factory :payment do
    description   "payment"
    amount        100
  end
end
