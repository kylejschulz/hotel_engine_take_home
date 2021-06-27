FactoryBot.define do
  factory :search do
    IATA_code { "MyString" }
    radius { 1 }
    room_quantity { 1 }
    check_in_date { "MyString" }
    check_out_date { "MyString" }
  end
end
