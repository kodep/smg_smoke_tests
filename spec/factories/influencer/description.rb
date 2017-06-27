FactoryGirl.define do
  factory :st_influencer_description, class: OpenStruct do
    hotel_frequency 'regularly'
    restaurant_frequency 'regularly'
    bar_frequency 'regularly'
    club_frequency 'regularly'
    for_what_ig_use 'personal_shot'
    how_often_ig_post 'multiple_per_day'
    accounts { create_list :st_influencer_description_account, 1 }
  end
end
