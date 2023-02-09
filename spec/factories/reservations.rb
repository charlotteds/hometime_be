FactoryBot.define do
  factory :reservation do
    code { "MyString" }
    start_date { "2023-02-07" }
    end_date { "2023-02-07" }
    nights { 1 }
    guests_count { 1 }
    adults_count { 1 }
    children_count { 1 }
    infants_count { 1 }
    status { "MyString" }
    currency { "MyString" }
    payout_price { 1.5 }
    security_price { 1.5 }
    total_price { 1.5 }
    association :guest
  end
end
