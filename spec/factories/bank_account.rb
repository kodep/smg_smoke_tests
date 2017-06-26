FactoryGirl.define do
  factory :af_bank_account, class: OpenStruct do
    sort_code       { Faker::Number.between(11, 99).to_s }
    bank_number     'GB29NWBK60161331926819'
    account_number  { Faker::Business.credit_card_number }
    name_on_account 'brave'
    address         { Faker::Address.street_address }
    city            { Faker::Address.city }
    country         { Faker::Address.country }
    phone_number    { "375#{Faker::Number.number(10)}" }
    postal_code     { Faker::Address.postcode }
    date_of_birth   { Faker::Date.between(150.years.ago, 20.years.ago) }
  end
end