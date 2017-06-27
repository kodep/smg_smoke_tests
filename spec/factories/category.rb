FactoryGirl.define do
  factory :st_category, class: OpenStruct do
    trait :first_category do
      from                0
      to                  999
      photo_price         0
      video_price         103
      boomerang_price     28
      rate                0
    end

    trait :second_category do
      from                1000
      to                  9999
      photo_price         3
      video_price         106
      boomerang_price     31
      rate                0.5
    end

    trait :third_category do
      from                10_000
      to                  19_999
      photo_price         30
      video_price         130
      boomerang_price     55
      rate                0.3
    end
  end
end