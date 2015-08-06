FactoryGirl.define do
  factory :screening do
    title "MyString"
    location "MyString"
    location_name "Some Location"
    time_date "2015-07-10 02:11:59"
    terms_n_conditions "MyText"
    parseid SecureRandom.hex
  end
end
