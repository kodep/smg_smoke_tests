FactoryGirl.define do
  factory :st_advert, class: OpenStruct do
    offering            'Offering....'
    influencers_max     { Faker::Number.between(11, 99) }
    images              { create_list :st_advert_image, 1 }
    advert_type         { ['free', 'basic', 'premium',
                           'platinum subscription', 'platinum per ad'].sample }

    association :package, factory: :st_package
    trait :first_advert do
      title 'New advert 1'
    end

    trait :second_advert do
      title 'New advert 2'
    end

    trait :third_advert do
      title 'New advert 3'
    end
  end
end
