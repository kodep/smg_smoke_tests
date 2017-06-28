FactoryGirl.define do
  factory :st_user_transaction, class: OpenStruct do
    description               { Faker::Company.catch_phrase }
    amount                    { Faker::Number.between(100, 1000) }
    type                      { %i(in_pay out_pay refund payment salary
                                   extra_commission lb_referral_reward award promote
                                   complimentary_credits).sample }
  end
end
