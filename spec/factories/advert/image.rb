FactoryGirl.define do
  factory :st_advert_image, class: OpenStruct do
    remote_image_url    { Faker::Avatar.image }
  end
end