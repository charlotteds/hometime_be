FactoryBot.define do
  factory :phone_number do
    value { "MyString" }
    guest { create :guest }
  end
end
