FactoryGirl.define do
  factory :f_referral, class: OpenStruct do
    referral_token                'AAAAAAAAAAAAAAAAAAAA'
    sequence(:passed)  { |n| n % 2 == 0  }
    sequence(:referral_email)  { |n| "userwithinvite#{n % 2}@mail.com" }
  end
end
