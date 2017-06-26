FactoryGirl.define do
  factory :af_influencer_instagram_account, class: OpenStruct do
    username 'user1'
    access_token '3504628112.c3ah2ee.b54fc10ssca746caba98c5655e8c5f06'
    instagram_id 350462801212112
    influencer_size 17000
    likes_score 0.3
    comments_score 0.4

    trait(:n1) {}

    trait :n2 do
      access_token '1504628112.c3ah2ee.b54fc10ssca746caba98c5655e8c5f06'
      influencer_size 20
      comments_score 0.5
    end
    trait :n3 do
      access_token '6504628112.c3ah2ee.b54fc10ssca746caba98c5655e8c5f06'
      influencer_size 16000
      likes_score 0.7
    end
  end
end
