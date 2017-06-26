FactoryGirl.define do
  factory :af_publisher_description do
    # influencers_size              { Faker::Number.number(3) }

    factory :af_publisher_business_description, class: OpenStruct do
      target_market               { Faker::Commerce.department }
      familiarity                 { Faker::Company.buzzword }
      # customer_age                { %w(any_age 18-24 25-34 35-44 45-59 60+).sample }
      marketing_objectives        { Faker::Company.catch_phrase }
      goals_and_budget            { Faker::Number.between(100, 1000) }
      other_marketing             { Faker::ChuckNorris.fact }
      social_usernames            { Faker::Internet.user_name }
    end

    factory :af_publisher_pr_agency_description, class: OpenStruct do
    end
  end
end
