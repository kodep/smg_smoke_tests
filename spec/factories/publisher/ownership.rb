FactoryGirl.define do
  factory :af_publisher_ownership, class: OpenStruct do
    name                    'ownership'
    type                    'bar'
    address                 { Faker::Address.street_address }
    longitude               { Faker::Address.longitude }
    latitude                { Faker::Address.latitude }

    association :hotel, factory: :af_publisher_ownership_hotel
    association :restaurant, factory: :af_publisher_ownership_restaurant
  end
end
