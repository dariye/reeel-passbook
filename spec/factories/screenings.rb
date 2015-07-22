FactoryGirl.define do
  factory :screening do
    title "MyString"
    location "MyString"
    location_name "Some Location"
    time_date "2015-07-10 02:11:59"
    terms_n_conditions "MyText"
    parse_id SecureRandom.hex
  end
end
