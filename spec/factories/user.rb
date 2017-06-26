FactoryGirl.define do
  factory :af_user, class: OpenStruct do
    first_name      'user1'
    last_name       'smith'
    password        'qwe123'
    confirmed_at    Time.now
    email           'admin@mail.com'
    referrals       { create_list(:f_referral, 2) }

    trait :admin do
      roles { create_list :af_role, 1, :admin }
    end

    trait :influencer do
      paypal_email          { Faker::Internet.email }
      credits               { Faker::Number.between(11, 99) }
      sequence(:email)      { |n| "user-influencer-#{n}@mail.com" }
      sequence(:first_name) { |n| "user#{n}" }
      roles                 { create_list :af_role, 1, :influencer }
    end

    trait :publisher do
      sequence(:email)      { |n| "user-publisher-#{100 - n}@mail.com" }
      sequence(:first_name) { |n| "user#{n + 3}" }
      roles                 { create_list :af_role, 1, :publisher }
    end
  end
end
