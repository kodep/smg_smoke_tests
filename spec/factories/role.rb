FactoryGirl.define do
  factory :st_role, class: OpenStruct do
    trait :admin do
      name 'admin'
    end

    trait :influencer do
      name 'influencer'
    end

    trait :publisher do
      name 'publisher'
    end
  end
end
