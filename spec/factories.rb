FactoryGirl.define do

  sequence(:name) { |n| "member#{n}" }
  sequence(:email) { |n| "member#{n}@example.com" }

  factory :member do
    name                  
    email
    password              "foobar123"
    password_confirmation "foobar123"
    confirmed_at          DateTime.now
    roles                 [:basic]

    factory :event_manager do
      roles               [:basic, :manage_events]
    end

    factory :album_manager do
      roles               [:basic, :manage_albums]
    end

    factory :admin do
      roles               [:admin]
    end
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
    type          "ReimbursementRequest"
    description   "request"
    amount        100
    receipt       Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'FratCoverPic.jpg'), 'image/jpg')
  end

  factory :reimbursement do
    type          "Reimbursement"
    description   "reimbursement"
    amount        100
  end

  factory :charge do
    type          "Charge"
    description   "charge"
    amount        100
  end

  factory :payment do
    type          "Payment"
    description   "payment"
    amount        100
  end
end
