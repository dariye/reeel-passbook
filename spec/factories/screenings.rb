FactoryGirl.define do
  factory :screening do
    title "MyString"
    location "MyString"
    time_date "2015-07-10 02:11:59"
    terms_n_conditions "MyText"
    pass_barcode_string "MyString"
    parse_screening_object_id 'Some String'
  end
end
