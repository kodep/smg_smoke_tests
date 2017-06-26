FactoryGirl.define do
  factory :af_advert, class: OpenStruct do
    offering            'Offering....'
    influencers_max     { Faker::Number.between(11, 99) }
    images              { create_list :af_advert_image, 1 }

    association :package, factory: :af_package
    trait :first_advert do
      title 'New advert 1'
      # association :category, factory: [:af_category, :first_category]
    end

    trait :second_advert do
      title 'New advert 2'
      # association :category, factory: [:af_category, :second_category]
    end

    trait :third_advert do
      title 'New advert 3'
      # association :category, factory: [:af_category, :third_category]
    end
  end
end