FactoryGirl.define do
  factory :st_user, class: OpenStruct do
    first_name      'user1'
    last_name       'smith'
    confirmed_at    Time.now
    email           'smoke_tests_admin@mail.com'
    referrals       { create_list(:st_referral, 2) }
    password        'password'
    password_confirmation 'password'

    trait :admin do
      roles { create_list :st_role, 1, :admin }
    end

    trait :influencer do
      paypal_email          { Faker::Internet.email }
      credits               { Faker::Number.between(11, 99) }
      sequence(:email)      { |n| "smoke_tests_user-influencer-#{n}@mail.com" }
      sequence(:first_name) { |n| "user#{n}" }
      roles                 { create_list :st_role, 1, :influencer }
    end

    trait :publisher do
      sequence(:email)      { |n| "smoke_tests_user-publisher-#{100 - n}@mail.com" }
      sequence(:first_name) { |n| "user#{n + 3}" }
      roles                 { create_list :st_role, 1, :publisher }
    end
  end
end
