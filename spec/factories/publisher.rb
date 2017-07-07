FactoryGirl.define do
  factory :st_publisher, class: OpenStruct do
    phone             { Faker::Code.ean }
    address           { Faker::Address.street_address }
    name              'Smoke Test Publisher'
    key_contact_name  { Faker::Name.name }
    key_contact_email { Faker::Internet.email }
    feedback_score    { Faker::Number.decimal(1, 1) }

    sequence(:ownership_type) do |n|
      cycle = %w(hotel restaurant).cycle.each
      (n - 1).times { cycle.next }
      cycle.peek
    end
    association :hotel, factory: :st_publisher_ownership_hotel
    association :restaurant, factory: :st_publisher_ownership_restaurant

    association :user, :publisher, factory: :st_user
    ownerships { |publisher| create_list :st_publisher_ownership, 2, type: publisher.ownership_type }

    factory :st_publisher_business, class: OpenStruct do
      type    'Publisher::Business'
      association :description, factory: :st_publisher_business_description
    end

    factory :st_publisher_pr_agency, class: OpenStruct do
      type    'Publisher::PrAgency'
      association :description, factory: :st_publisher_pr_agency_description
    end

    trait(:n1) do
      adverts { create_list :st_advert, 10, :first_advert }
    end

    trait(:n2) do
      adverts { create_list :st_advert, 10, :second_advert }
    end

    trait(:n3) do
      adverts { create_list :st_advert, 10, :third_advert }
    end

    before(:create) do |publisher|
      publisher.adverts.try(:each) { |advert| advert.ownership = publisher.ownerships.first }
    end
  end
end
