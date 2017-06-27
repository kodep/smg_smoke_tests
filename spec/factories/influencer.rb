FactoryGirl.define do
  factory :st_influencer, class: OpenStruct do
    credibility_score 0.2
    leisure_expertise_score 0.4
    feedback_score 3.2
    association :user, :influencer, factory: :st_user
    association :bank_account, factory: :st_bank_account
    association :description, factory: :st_influencer_description

    trait(:n1) do
      association :instagram_account, :n1, factory: :st_influencer_instagram_account
    end

    trait :n2 do
      association :instagram_account, :n2, factory: :st_influencer_instagram_account
      feedback_score 4.6
    end

    trait :n3 do
      association :instagram_account, :n3, factory: :st_influencer_instagram_account
      credibility_score 0.5
      leisure_expertise_score 0.8
      feedback_score 4.6
    end
  end
end
